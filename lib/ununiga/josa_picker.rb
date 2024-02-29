require 'ununiga/jaso_splitter'

module Ununiga
  # 한글 조사 변경 클래스
  class JosaPicker
    JOSAS = [%w(은 는),
             %w(이 가),
             %w(을 를),
             %w(과 와),
             %w(으로 로),
             %w(이의 의),
             %w(이),
            ].freeze

    attr_reader :korean_str, :is_html

    class << self
      def takewell(str)
        new(str).takewell
      end
    end

    def initialize(str, is_html = false)
      @korean_str = str
      @is_html = is_html
    end

    def takewell
      korean_str.gsub josa_regexp do |matched|
        index = $~.offset(0)[0]
        if index == 0
          matched
        else
          josa = JOSAS.find { |jo| josa_convension(jo).include? matched }
          preceding_char = if is_html
            korean_str[0...index].gsub(/<[^>]*>/, "")[-1]
          else
            korean_str[index - 1]
          end
          splitter = JasoSplitter.new(preceding_char)
          josa[(splitter.jongsung ? 0 : 1)]
        end
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
          josa_regexp_seq = JOSAS.map do |josa|
            conv = josa_convension(josa)
            conv.map { |str| str.gsub!('(', '\\(').gsub!(')', '\\)') }
          end
          Regexp.new(josa_regexp_seq.flatten.join('|'))
        end
    end

    def josa_convension(josa)
      if josa[0].size == 1
        ["#{josa[0]}(#{josa[1]})", "#{josa[1]}(#{josa[0]})"]
      elsif josa[0].size == 2
        ["(#{josa[0][0]})#{josa[1]}"]
      end
    end
  end
end
