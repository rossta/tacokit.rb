require "bundler"
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = "--color --format progress"
end

require "rubocop/rake_task"
RuboCop::RakeTask.new

task test: [:spec, :rubocop]
task default: [:spec, :rubocop]
