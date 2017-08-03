require 'net/dav'

module Cm
  module FileManager
    module Connectors
      class WebDavConnector < BaseConnector
        def write(file_path, body)
          path = URI.encode(file_path)
          web_dav.put_string(path, body)
        end

        def read(file_path)
          path = URI.encode(file_path)
          web_dav.get(path).force_encoding("UTF-8").encode("UTF-8")
        end

        def delete(file_path)
          path = URI.encode(file_path)
          web_dav.delete(path)
        end

        def upload(file_path, source_file_path)
          path = URI.encode(file_path)

          File.open(source_file_path, 'r') do |stream|
            web_dav.put(path, stream, File.size(source_file_path))
          end
        end

        private

        def web_dav
          @web_dav ||= Net::DAV.new(options[:url])
        end
      end
    end
  end
end
