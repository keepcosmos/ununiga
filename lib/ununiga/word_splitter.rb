module Ununiga
  # 한글 초성, 중성, 종성 분리기
  class KoreanSplitter
    
    
    attr_reader :korean_str

    def initialize(korean_str)
      @korean_str = korean_str
    end

    def split_jaso(char)
      
      
    end

    def extract_chosung(char)
      CHOSUNGS[kr_relative_code(char) / (JUNGSUNGS.size * JONGSUNGS.size)]
    end

    def extract_jungsung(char)
      
    end

    def kr_relative_code(char)
      decoded = char.unpack('U')[0]
      decoded - KR_OFFSET
    end
  end
end
