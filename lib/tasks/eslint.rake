ENV['EXECJS_RUNTIME'] = 'RubyRacer'

require 'eslint-rails'

namespace :eslint do
  def run_and_print_results(file, should_autocorrect=false)
    warnings = ESLintRails::Runner.new(file).run(should_autocorrect)

    if warnings.empty?
      puts 'All good! :)'.green
      exit 0
    else
      formatter = ESLintRails::TextFormatter.new(warnings)
      formatter.format
      exit 1
    end
  end

  desc %{Run ESLint against the specified JavaScript file and report warnings (default is 'application')}
  task :run, [:filename, :should_autocorrect] => :environment do |_, args|
    formatted_should_autocorrect = ['true'].include?(args[:should_autocorrect]) ? true : false
    run_and_print_results(args[:filename] || 'application', formatted_should_autocorrect)
  end

  desc 'Run ESLint against all project javascript files and report warnings'
  task :run_all, [:should_autocorrect] => :environment do |_, args|
    formatted_should_autocorrect = ['true'].include?(args[:should_autocorrect]) ? true : false
    run_all_args = {
      should_autocorrect: formatted_should_autocorrect,
      filename: nil
    }
    run_and_print_results(run_all_args) # Run all
  end

  desc 'Print the current configuration file (Uses local config/eslint.json if it exists; uses default config/eslint.json if it does not; optionally force default by passing a parameter)'
  task :print_config, [:force_default] => :environment do |_, args|
    puts ESLintRails::Config.read(force_default: args[:force_default])
  end
end
