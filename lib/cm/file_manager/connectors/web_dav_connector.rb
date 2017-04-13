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
          web_dav.get(path)
        end

        def delete(file_path)
          path = URI.encode(file_path)
          web_dav.delete(path)
        end

        private

        def web_dav
          @web_dav ||= Net::DAV.new(options[:url])
        end
      end
    end
  end
end
