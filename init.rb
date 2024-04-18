require 'redmine'

Redmine::Plugin.register :redmine_regexidentifier do
  name 'Redmine Regex Identifier Plugin'
  author 'Markus Boremski'
  description 'This plugin checks the project identifier against a regex.'
  version '0.0.2'
  url 'https://github.com/mboremski/redmine_regexidentifier'
  author_url 'https://github.com/mboremski'
  settings default: {'regex' => '\Aed[0-9]*\z', 'enabled' => true}, partial: 'settings/redmine_regexidentifier_settings'
end

Rails.configuration.to_prepare do
  require_dependency 'project'
  require_dependency 'redmine_regexidentifier/project_patch'
  unless Project.included_modules.include?(RedmineRegexIdentifier::ProjectPatch)
    Project.send(:include, RedmineRegexIdentifier::ProjectPatch)
  end
end
