require 'cm/file_manager/version'
require 'cm/file_manager/connectors'
require 'cm/file_manager/connectors/local_fs_connector'
require 'cm/file_manager/connectors/web_dav_connector'

module Cm
  module FileManager
    CONNECTORS = {
      local_fs: Connectors::LocalFsConnector,
      web_dav: Connectors::WebDavConnector
    }.freeze

    mattr_accessor :options

    class << self

      def read(file_path)
        connector.read(full_path(file_path))
      end

      def write(file_path, body)
        full_path(file_path).tap do |path|
          connector.write(path, body)
        end
        file_path
      end

      def delete(file_path)
        full_path(file_path).tap do |path|
          connector.delete(path)
        end
        file_path
      end

      def mkdir(dir_path)
        full_path(dir_path).tap do |path|
          connector.mkdir(path)
        end
        dir_path
      end

      private

      def connector
        @connector ||= CONNECTORS[connector_type].new(options)
      end

      def connector_type
        options[:connector]
      end

      def base_path
        options[:base_path]
      end

      def full_path(entity)
        [base_path, entity].join('/').squeeze('/')
      end
    end
  end
end
