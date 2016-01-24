require 'minitest/autorun'
require 'ununiga'

class UnunigaTest < Minitest::Test
  def test_ununiga
    assert_equal 'oh', Ununiga::Translator.oh
  end
end
