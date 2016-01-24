module Ununiga
  class JasoSplitter
    CHOSUNGS = %w(ㄱ ㄲ ㄴ ㄷ ㄸ ㄹ ㅁ ㅂ ㅃ ㅅ ㅆ ㅇ ㅈ ㅉ ㅊ ㅋ ㅌ ㅍ ㅎ).freeze
    JUNGSUNGS = %w(ㅏ ㅐ ㅑ ㅒ ㅓ ㅔ ㅕ ㅖ ㅗ ㅘ ㅛ ㅙ ㅚ ㅜ ㅝ ㅞ ㅟ ㅠ ㅡ ㅢ ㅣ).freeze
    JONGSUNGS = %w(ㄱ ㄲ ㄳ ㄴ ㄵ ㄶ ㄷ ㄹ ㄺ ㄻ ㄼ ㄽ ㄾ ㄿ ㅀ ㅁ ㅂ ㅄ ㅅ ㅆ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ).unshift(nil).freeze
    KR_RANGE = ('가'.unpack('U')[0]..'힣'.unpack('U')[0]).freeze
    KR_OFFSET = KR_RANGE.first.freeze

    attr_reader :kr_char, :kr_relative_code

    def initialize(kr_char)
      kr_code = kr_char.unpack('U')[0]
      
      fail ArgumentError, "'#{kr_char}' is not korean character" unless KR_RANGE.cover?(kr_code)
      fail ArgumentError, 'Argument must be single character' unless kr_char.size == 0
      
      @kr_char = kr_char
      @kr_relative_code = kr_code - KR_OFFSET
    end

    def split
      [extract_chosung, extract_jungsung, extract_jongsung]
    end

    def extract_chosung
      CHOSUNGS[kr_relative_code / (JUNGSUNGS.size * JONGSUNGS.size)]
    end

    def extract_jungsung
      JUNGSUNGS[kr_relative_code % (JUNGSUNGS.size * JONGSUNGS.size) / JONGSUNGS.size]
    end

    def extract_jongsung
      JONGSUNGS[kr_relative_code % JONGSUNGS.size]
    end
  end
end
