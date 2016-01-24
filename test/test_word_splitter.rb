require 'minitest/autorun'
require 'korean_splitter'

class UnunigaTest < Minitest::Test
  def test_split
    name = '전효성'
    splitter = Ununiga::WordSplitter.new(name)
    splitter.split
  end
end
