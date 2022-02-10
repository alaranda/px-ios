source "https://rubygems.org"

gem 'cocoapods', '~> 1.11.2 '
gem 'fastlane', '~>2.199.0'
gem 'danger', '~> 8.4.1'
gem 'danger-swiftlint'
gem 'git_diff_parser'
gem 'cocoapods-clean_build_phases_scripts', '~> 0.0.1'
gem 'danger-xcov'

# this enable fastlane plugins
plugins_path = File.join(File.dirname(__FILE__), '.fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)