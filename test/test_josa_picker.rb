require 'minitest/autorun'
require 'ununiga/josa_picker'

class JosaPickerTest < Minitest::Test
  def test_takewell
    assert_equal '철수가 개발을 좋아합니다.', takewell('철수이(가) 개발을(를) 좋아합니다.')
    assert_equal '레일즈는 루비를 사용합니다.', takewell('레일즈은(는) 루비을(를) 사용합니다.')
    assert_equal '레일즈는 루비를 사용합니다.', takewell('레일즈은(는) 루비을(를) 사용합니다.')
    assert_equal '레일즈와 쟝고는 싸우지 않습니다.', takewell('레일즈와(과) 쟝고은(는) 싸우지 않습니다.')
  end

  def takewell(str)
    Ununiga::JosaPicker.new(str).takewell
  end
end
