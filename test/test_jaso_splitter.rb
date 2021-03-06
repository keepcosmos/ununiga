require 'minitest/autorun'
require 'ununiga/jaso_splitter'

class JamoSplitterTest < Minitest::Test
  def test_extract_chosung
    testgroup = { '가' => 'ㄱ',
                  '낳' => 'ㄴ',
                  '짷' => 'ㅉ',
                  '하' => 'ㅎ'
                }
    testgroup.each do |char, chosung|
      splitter = Ununiga::JasoSplitter.new(char)
      assert_equal chosung, splitter.extract_chosung
    end
  end

  def test_extract_jungsung
    testgroup = { '가' => 'ㅏ',
                  '내' => 'ㅐ',
                  '찋' => 'ㅢ',
                  '휷' => 'ㅠ',
                  '쿄' => 'ㅛ',
                  '왜' => 'ㅙ'
                }
    testgroup.each do |char, jungsung|
      splitter = Ununiga::JasoSplitter.new(char)
      assert_equal jungsung, splitter.extract_jungsung
    end
  end

  def test_extract_jongsung
    testgroup = { '가' => nil,
                  '내' => nil,
                  '찋' => 'ㅎ',
                  '휷' => 'ㄳ'
                }
    testgroup.each do |char, jongsung|
      splitter = Ununiga::JasoSplitter.new(char)
      if jongsung
        assert_equal jongsung, splitter.extract_jongsung
      else
        assert_nil splitter.extract_jongsung
      end
    end
  end

  def test_split
    testgroup = { '신' => ['ㅅ', 'ㅣ', 'ㄴ'],
                  '재' => ['ㅈ', 'ㅐ', nil],
                  '현' => ['ㅎ', 'ㅕ', 'ㄴ'],
                  '꾢' => ['ㄲ', 'ㅛ', 'ㄶ']
                }
    testgroup.each do |char, splitted|
      splitter = Ununiga::JasoSplitter.new(char)
      assert_equal splitted, splitter.split
    end
  end

  def test_non_korean_exception
    %w(a 中 च Қ に).each do |char|
      assert !Ununiga::JasoSplitter.new(char).korean?
    end
  end

  def test_non_single_character_exception
    assert_raises ArgumentError do
      Ununiga::JasoSplitter.new('두글자')
    end
  end
end
