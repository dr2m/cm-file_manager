require 'test_helper'

class Cm::FileManagerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Cm::FileManager::VERSION
  end
end
