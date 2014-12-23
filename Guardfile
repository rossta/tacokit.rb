guard :rspec, cmd: "bundle exec rspec --format progress" do
  require "ostruct"

  rspec = OpenStruct.new
  rspec.spec = ->(m) { "spec/#{m}_spec.rb" }
  rspec.spec_dir = "spec"
  rspec.spec_helper = "spec/spec_helper.rb"

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| rspec.spec.(m[1]) }
  watch(rspec.spec_helper)      { rspec.spec_dir }
end
