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
  desc "Generate docs and publish to gh-pages"
  task :publish do
    begin
      require "yard"
    rescue LoadError => e
      if e.message =~ /yard/
        warn "Please install `gem install yard` first"
        exit
      else
        raise e
      end
    end

    require "fileutils"
    sh "yard doc"
    sh "git checkout gh-pages"
    sh "cp -R doc/* ."
    sh "git commit -vam 'Update documentation'"
    sh "git push origin gh-pages"
    sh "git checkout -"
  end
end
