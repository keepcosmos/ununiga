require 'ununiga/josa_picker'

module Ununiga::I18n
  module JosaTransformer
    def translate(*args)
      transform(super)
    end

    def transform(entry)
     return Ununiga::JosaPicker.new(entry).takewell if I18n.locale.to_s =~ /ko|ko_KR/i
      entry
    end
  end
end
