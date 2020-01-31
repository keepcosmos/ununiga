require 'minitest/autorun'
require 'ununiga/josa_picker'

class JosaPickerTest < Minitest::Test
  def test_takewell
    assert_equal '철수가 개발을 좋아합니다.', takewell('철수이(가) 개발을(를) 좋아합니다.')

    assert_equal '레일즈는 루비를 사용합니다.', takewell('레일즈은(는) 루비을(를) 사용합니다.')
    assert_equal '레일즈는 루비를 사용합니다.', takewell('레일즈는(은) 루비를(을) 사용합니다.')

    assert_equal '레일즈와 쟝고는 싸우지 않습니다.', takewell('레일즈와(과) 쟝고은(는) 싸우지 않습니다.')

    assert_equal '페이스북으로부터 인증되었습니다.', takewell('페이스북(으)로부터 인증되었습니다.')
    assert_equal '트위터로부터 인증되었습니다.', takewell('트위터(으)로부터 인증되었습니다.')
    
    assert_equal '초록이의 돌봄이 시작됩니다.', takewell('초록(이)의 돌봄이 시작됩니다.')
    assert_equal '앵두의 돌봄이 시작됩니다.', takewell('앵두(이)의 돌봄이 시작됩니다.')

    assert_equal '초록이 보호자님!', takewell('초록(이) 보호자님!')
    assert_equal '앵두 보호자님!', takewell('앵두(이) 보호자님!')
  end

  def test_find_josas
    str1 = '철수이(가) 개발을(를) 좋아합니다.'
    assert_equal [[2, %w(이 가)], [9, %w(을 를)]], find_josas(str1)

    str2 = '레일즈은(는) 루비을(를) 사용합니다.'
    assert_equal [[3, %w(은 는)], [10, %w(을 를)]], find_josas(str2)
  end

  def find_josas(str)
    Ununiga::JosaPicker.new(str).josas
  end

  def takewell(str)
    Ununiga::JosaPicker.new(str).takewell
  end
end
