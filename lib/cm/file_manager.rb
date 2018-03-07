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

    UNIQ_FILE_PATH_RANDOM_SEQUENCE_LENGTH = 3

    class << self
      attr_accessor :options

      def read(file_path)
        connector.read(full_path(file_path))
      end

      def write(file_path, body)
        uniq_path = uniq_file_path(file_path)
        full_path(uniq_path).tap do |path|
          connector.write(path, body)
        end
        uniq_path
      end

      def delete(file_path)
        full_path(file_path).tap do |path|
          connector.delete(path)
        end
        file_path
      end

      def upload(file_path, source_file_path)
        full_path(file_path).tap do |path|
          connector.upload(path, source_file_path)
        end
        file_path
      end

      def full_uri(file_path)
        prefix = options[:url]
        [prefix, full_path(file_path)].
          compact.
          join('/').
          gsub(/(?<!:)\/\/+/, '/')
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

      def uniq_file_path(file_path)
        prefix = Time.now.to_f.to_s.sub('.', '') + get_random_sequence

        filename = File.basename(file_path)
        dirname  = File.dirname(file_path)
        File.join(dirname, "#{prefix}.#{filename}")
      end

      def get_random_sequence(length = UNIQ_FILE_PATH_RANDOM_SEQUENCE_LENGTH)
        rand(10 ** length).to_s.rjust(length, '0')
      end
    end
  end
end
