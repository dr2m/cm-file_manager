module Cm
  module FileManager
    module Connectors
      class BaseConnector
        attr_reader :options, :base_path

        def initialize(**options)
          @options = options
        end

        def read(file_path)
          raise NotImplementedError
        end

        def write(file_path, body)
          raise NotImplementedError
        end

        def delete(file_path)
          raise NotImplementedError
        end

        def upload(file_path)
          raise NotImplementedError
        end
      end
    end
  end
end
