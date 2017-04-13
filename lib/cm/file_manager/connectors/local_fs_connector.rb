module Cm
  module FileManager
    module Connectors
      class LocalFsConnector < BaseConnector
        def write(file_path, body)
          dir_path = File.dirname(file_path)
          mkdir(dir_path) unless Dir.exist?(dir_path)
          File.write(file_path, body)
        end

        def read(file_path)
          File.read(file_path)
        end

        def delete(file_path)
          if File.directory?(file_path)
            Dir.rmdir(file_path)
          else
            File.delete(file_path)
          end
        end

        private

        def mkdir(dir_path)
          FileUtils.mkdir_p(dir_path)
        end
      end
    end
  end
end
