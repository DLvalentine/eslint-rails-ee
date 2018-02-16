ENV['EXECJS_RUNTIME'] = 'RubyRacer'

require 'eslint-rails-ee'

namespace :eslint do
  def run_and_print_results(file, should_autocorrect=false)
    warnings   = ESLintRails::Runner.new(file).run(should_autocorrect)
    raiseError = false

    warnings.each do |warning|
      next if warning.severity.nil?
      if warning.severity.to_s.casecmp('high').zero?
        raiseError = true
        break
      end 
    end

    if warnings.empty?
      puts 'All files passed! Any issues that might have existed may have been auto-corrected :)'.green
      exit 0
    elsif !raiseError
      formatter = ESLintRails::TextFormatter.new(warnings)
      puts formatter.format(should_autocorrect)
      puts 'eslint reports some warnings, but they are minor enough to be passable. Might want to fix them up before release, though. :/'.yellow
      exit 0
    else
      formatter = ESLintRails::TextFormatter.new(warnings)
      puts formatter.format(should_autocorrect)
      puts 'Major issues exist according to provided eslint rules. You *MUST* git gud and correct these issues before release :('.red
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
    run_and_print_results(nil, formatted_should_autocorrect) # Run all
  end

  desc 'Print the current configuration file (Uses local config/eslint.json if it exists; uses default config/eslint.json if it does not; optionally force default by passing a parameter)'
  task :print_config, [:force_default] => :environment do |_, args|
    puts ESLintRails::Config.read(force_default: args[:force_default])
  end
end
