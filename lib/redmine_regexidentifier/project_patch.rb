require_dependency 'project'

module RedmineRegexIdentifier
  module ProjectPatch
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        validate :validate_identifier_regex
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def validate_identifier_regex
        regex_string = Setting.plugin_redmine_regexidentifier['regex']
        regex_string_without_linebreaks = regex_string.gsub(/[\r\n]+/, '')
        regex = Regexp.new(regex_string_without_linebreaks)
        unless regex.match(identifier)
          errors.add(:identifier, :invalid)
        end
      end
    end
  end
end

Project.send(:include, RedmineRegexIdentifier::ProjectPatch)
