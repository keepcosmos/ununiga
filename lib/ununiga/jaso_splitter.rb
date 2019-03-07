module Ununiga
  # 한글 자소분리 클래스
  # 1개의 한글 문자를 초성/중성/종성으로 분리한다.
  #
  # Sample:
  # 
  #     splitter = Ununiga::JasoSplitter.new('흯')
  #     splitter.extract_chosung       # => 'ㅎ'
  #     splitter.extract_jungsung      # => 'ㅢ'
  #     splitter.extract_jongsung      # => 'ㄳ'
  #     splitter.split                 # => ['ㅎ', 'ㅢ', 'ㄳ']
  #
  #     # 종성이 없는 경우는 nil
  #     splitter2 = Ununiga::JasoSplitter.new('가')
  #     splitter2.extract_jongsung     # => nil
  #     splitter2.split                # => ['ㄱ', 'ㅏ', nil]
  # 
  class JasoSplitter
    CHOSUNGS = %w(ㄱ ㄲ ㄴ ㄷ ㄸ ㄹ ㅁ ㅂ ㅃ ㅅ ㅆ ㅇ ㅈ ㅉ ㅊ ㅋ ㅌ ㅍ ㅎ).freeze
    JUNGSUNGS = %w(ㅏ ㅐ ㅑ ㅒ ㅓ ㅔ ㅕ ㅖ ㅗ ㅘ ㅙ ㅚ ㅛ ㅜ ㅝ ㅞ ㅟ ㅠ ㅡ ㅢ ㅣ).freeze
    JONGSUNGS = %w(ㄱ ㄲ ㄳ ㄴ ㄵ ㄶ ㄷ ㄹ ㄺ ㄻ ㄼ ㄽ ㄾ ㄿ ㅀ ㅁ ㅂ ㅄ ㅅ ㅆ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ).unshift(nil).freeze
    KR_RANGE = ('가'.unpack('U')[0]..'힣'.unpack('U')[0]).freeze
    KR_OFFSET = KR_RANGE.first.freeze

    attr_reader :kr_char

    def initialize(kr_char)
      fail ArgumentError, 'Argument must be single character' unless kr_char.size == 1
      @kr_char = kr_char
    end

    def split
      [extract_chosung, extract_jungsung, extract_jongsung]
    end

    def extract_chosung
      nil unless korean?
      CHOSUNGS[kr_relative_code / (JUNGSUNGS.size * JONGSUNGS.size)]
    end

    def extract_jungsung
      nil unless korean?
      JUNGSUNGS[kr_relative_code % (JUNGSUNGS.size * JONGSUNGS.size) / JONGSUNGS.size]
    end

    def extract_jongsung
      nil unless korean?
      JONGSUNGS[kr_relative_code % JONGSUNGS.size]
    end

    def korean?
      KR_RANGE.cover?(kr_code)
    end

    [:chosung, :jungsung, :jongsung].each do |m|
      alias_method m, :"extract_#{m}"
    end

    private

    def kr_code
      kr_char.unpack('U')[0]
    end

    def kr_relative_code
      kr_code - KR_OFFSET
    end
  end
end
