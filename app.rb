require 'sinatra/base'
require 'oauth'
require 'rack/csrf'
require 'securerandom'
require 'active_support/core_ext/string'

class TrelloOauth < Sinatra::Base
  use Rack::Logger

  use Rack::Session::Cookie, secret: ENV.fetch('SESSION_SECRET', SecureRandom.hex(32))
  use Rack::Csrf, raise: true

  enable :protection

  set :app_name   , ENV.fetch('TRELLO_APP_NAME', 'Tacokit')
  set :app_key    , ENV.fetch('TRELLO_APP_KEY')
  set :app_secret , ENV.fetch('TRELLO_APP_SECRET')

  set :site               , "https://trello.com"
  set :request_token_path , "/1/OAuthGetRequestToken"
  set :authorize_path     , "/1/OAuthAuthorizeToken"
  set :access_token_path  , "/1/OAuthGetAccessToken"

  set :force_ssl, false
  set :debug, false
  # set :show_exceptions, false

  configure :production do
    set :force_ssl, true
  end

  helpers do
    def csrf_token
      Rack::Csrf.csrf_token(env)
    end

    def csrf_tag
      Rack::Csrf.csrf_tag(env)
    end

    def app_name
      params[:app_name] || session[:app_name] || settings.app_name
    end

    def app_key
      if settings.debug
        settings.app_key
      else
        params[:app_key] || session[:app_key]
      end
    end

    def app_secret
      if settings.debug
        settings.app_secret
      else
        params[:app_secret] || session[:app_secret]
      end
    end
  end

  before do
    session[:_init] = '1'
    log_request

    if settings.force_ssl && !request.secure?
      halt 400, "Please use SSL: <a href='#{ssl_url("/")}'>#{ssl_url("/")}</a>"
    end
  end

  IncompleteCredentials = Class.new(RuntimeError)

  error IncompleteCredentials do
    "Please provide both your TRELLO_APP_KEY and your TRELLO_APP_SECRET. <a href='/'>Back</a>"
  end

  get "/" do
    erb :index
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

  post "/connect" do
    raise IncompleteCredentials unless params[:app_key].present? && params[:app_secret].present?
    session[:app_key] = params[:app_key]
    session[:app_secret] = params[:app_secret]
    redirect request_token.authorize_url(oauth_callback: callback_url, name: app_name)
  end

  post "/webhook" do
    logger.info "webhook received"
    status 200
  end

  head "/webhook" do
    status 200
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
                           consumer.get_request_token(oauth_callback: callback_url).tap do |rtoken|
                             session[:request_token] = rtoken.token
                             session[:request_token_secret] = rtoken.secret
                           end
                         end
                       end
  end

  def consumer
    @consumer ||= ::OAuth::Consumer.new(app_key, app_secret,
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

  def ssl_uri(addr = nil, absolute = true, add_script_name = true)
    return addr if addr =~ /\A[A-z][A-z0-9\+\.\-]*:/
    uri = [host = ""]
    if absolute
      host << "https://"
      if request.forwarded? or request.port != (request.secure? ? 443 : 80)
        host << request.host_with_port
      else
        host << request.host
      end
    end
    uri << request.script_name.to_s if add_script_name
    uri << (addr ? addr : request.path_info).to_s
    File.join uri
  end

  alias ssl_url ssl_uri

end
