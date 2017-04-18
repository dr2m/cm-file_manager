require 'test_helper'

class Cm::FileManagerTest < Minitest::Test
  def setup
    @file_manager = Cm::FileManager
    @path = '//foo/bar///baz////file.txt'
  end

  def options_for_local_fs
    {
      base_path: '/tmp/storage',
      connector: :local_fs
    }
  end

  def options_for_web_dav
    {
      base_path: '/campaign-management/tmp',
      connector: :web_dav,
      url: 'http://foo.bar-baz.ru'
    }
  end

  def test_that_it_has_a_version_number
    refute_nil ::Cm::FileManager::VERSION
  end

  def test_full_uri_for_local_fs
    @file_manager.options = options_for_local_fs
    assert_equal @file_manager.full_uri(@path), '/tmp/storage/foo/bar/baz/file.txt'
  end

  def test_full_uri_for_web_dav
    @file_manager.options = options_for_web_dav
    assert_equal @file_manager.full_uri(@path), 'http://foo.bar-baz.r/campaign-management/tmp/foo/bar/baz/file.txt'
  end
end
