# require "bundler/gem_tasks"
require "rspec/core/rake_task"

task :default => :spec
task :test => :spec

desc 'Do not use; use the spec task'
RSpec::Core::RakeTask.new(:rspec)

desc 'Runs specifications for all gems'
task :spec => [:'spec:http', :'spec:routing']
namespace :spec do
  %i[http routing].each do |lib|
    desc "Runs specifications for the xenon-#{lib} gem"
    task lib do
      Dir.chdir("xenon-#{lib}") do
        Rake::Task['rspec'].reenable
        Rake::Task['rspec'].invoke
      end
    end
  end
end

desc 'Build gems into the pkg directory'
task :build do
  FileUtils.rm_rf('pkg')
  Dir[File.join('*', '*.gemspec')].each do |gemspec|
    system "gem build #{gemspec}"
  end
  system "gem build xenon.gemspec"
  FileUtils.mkdir_p('pkg')
  FileUtils.mv(Dir['*.gem'], 'pkg')
end

desc 'Tags version, pushes to remote, and pushes gems'
task :release => :build do
  sh 'git', 'tag', '-m', changelog, "v#{Xenon::VERSION}"
  sh "git push origin master"
  sh "ls pkg/*.gem | xargs -n 1 gem push"
end
