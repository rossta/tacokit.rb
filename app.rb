require 'oauth'
require 'sinatra/base'

class TrelloOauth < Sinatra::Base
  use Rack::Logger

  enable :sessions

  set :app_name   , ENV.fetch('TRELLO_APP_NAME', 'Tacokit')
  set :app_key    , ENV.fetch('TRELLO_APP_KEY')
  set :app_secret , ENV.fetch('TRELLO_APP_SECRET')

  set :site               , "https://trello.com"
  set :request_token_path , "/1/OAuthGetRequestToken"
  set :authorize_path     , "/1/OAuthAuthorizeToken"
  set :access_token_path  , "/1/OAuthGetAccessToken"

  before do
    log_request
  end

  get "/" do
    <<-HTML
    <html>
      #{welcome_message}
      <p><a href="/clear">Clear session</a></p>
    </html>
    HTML
  end

  get "/authorize" do
    if oauth_verified?
      redirect to("/")
    else
      redirect request_token.authorize_url(oauth_callback: callback_url, name: settings.app_name)
    end
  end

  get "/callback" do
    oauth_verify! params[:oauth_verifier]
    redirect to("/")
  end

  get "/clear" do
    session.clear
    redirect to("/")
  end

  private

  def callback_url
    url("/callback")
  end

  def request_token
    @request_token ||= begin
                         if session[:request_token] && session[:request_token_secret]
                           ::OAuth::RequestToken.new(consumer, session.delete(:request_token),
                                                     session.delete(:request_token_secret))
                         else
                           rtoken = consumer.get_request_token(oauth_callback: callback_url)
                           session[:request_token] = rtoken.token
                           session[:request_token_secret] = rtoken.secret
                           rtoken
                         end
                       end
  end

  def consumer
    @consumer ||= ::OAuth::Consumer.new(settings.app_key, settings.app_secret,
                                        site:                settings.site,
                                        request_token_path:  settings.request_token_path,
                                        authorize_path:      settings.authorize_path,
                                        access_token_path:   settings.access_token_path,
                                        http_method:         :get)
  end

  def expire_request_token!
    session.delete(:request_token)
    session.delete(:request_token_secret)
  end

  def oauth_verify!(oauth_verifier)
    @access_token = request_token.get_access_token(oauth_verifier: params[:oauth_verifier])

    store_access_token! @access_token

    @access_token
  end

  def oauth_verified?
    !!session[:oauth_token] && !!session[:oauth_secret]
  end

  def store_access_token!(access_token)
    # Request token is invalidated after retrieving access_token
    session.clear

    session[:oauth_token]  = access_token.token
    session[:oauth_secret] = access_token.secret
  end

  def logger
    request.logger
  end

  def log_request
    logger.info "params  : #{params.inspect}"
    logger.info "session : #{session.inspect}"
  end

  def welcome_message
    if oauth_verified?
      verified_message
    else
      unverified_message
    end
  end

  def verified_message
    <<-HTML
      <h1>#{%w[ Boom Sweet Success Goal Score ].sample}!</h1>
      <p>Here are your OAuth credentials. Keep them safe!</p>
      <p>token: #{session[:oauth_token]}</p>
      <p>secret: #{session[:oauth_secret]}</p>
    HTML
  end

  def unverified_message
    <<-HTML
      <h1>Welcome</h1>
      <p><a href="/authorize">Connect to Trello</a> to get your OAuth access token and secret.</p>
      <p>App credentials</p>
      <p>name: #{settings.app_name}</p>
      <p>key: #{settings.app_key}</p>
      <p>secret: #{settings.app_secret}</p>
    HTML
  end

end
