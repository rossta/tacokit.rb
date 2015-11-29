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

namespace :doc do
  begin
    require 'yard'
    YARD::Rake::YardocTask.new do |task|
      task.files   = ['README.md', 'LICENSE.md', 'lib/**/*.rb']
      task.options = [
        '--markup', 'markdown',
      ]
    end
  rescue LoadError
  end
end
