require 'ununiga/jaso_splitter'

module Ununiga
  # 한글 초성, 중성, 종성 분리기
  class JosaPicker
    JOSAS = [%w(은 는),
             %w(이 가),
             %w(을 를),
             %w(과 와)].freeze

    attr_reader :korean_str

    def initialize(str)
      @korean_str = str
    end

    def takewell
      korean_str.gsub josa_regexp do |matched|
        index = $~.offset(0)[0]
        next if index == 0
        josa = JOSAS.find { |josa| josa.include? matched[0] }
        splitter = JasoSplitter.new(korean_str[index - 1])
        josa[(splitter.jongsung ? 0 : 1)]
      end
    end

    def josas
      res = []
      korean_str.scan josa_regexp do |matched|
        res << [$~.offset(0)[0], JOSAS.find { |josa| josa.include? matched[0] }]
      end
      res
    end

    private

    def josa_regexp
      @_josa_regexp ||=
        begin
          josa_regexp_seq = JOSAS.map { |a| ["#{a[0]}\\(#{a[1]}\\)".freeze, "#{a[1]}\\(#{a[0]}\\)".freeze] }
          Regexp.new(josa_regexp_seq.flatten.join('|'))
        end
    end
  end
end
