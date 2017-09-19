module Cm
  module FileManager
    module Connectors
      class LocalFsConnector < BaseConnector
        def write(file_path, body)
          ensure_directory_exists(file_path)
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

        def upload(file_path, source_file_path)
          File.open(source_file_path, 'rb') do |input_stream|
            ensure_directory_exists(file_path)

            File.open(file_path, 'wb') do |output_stream|
              IO.copy_stream(input_stream, output_stream)
            end
          end
        end

        private

        def ensure_directory_exists(file_path)
          dir_path = File.dirname(file_path)
          mkdir(dir_path) unless Dir.exist?(dir_path)
        end
      end
    end
  end
end
