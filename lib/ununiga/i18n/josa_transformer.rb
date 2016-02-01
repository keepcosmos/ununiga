require 'ununiga/josa_picker'

module Ununiga::I18n
  module JosaTransformer
    def translate(*args)
      transform(super)
    end

    def transform(entry)
      if entry.is_a?(String) && I18n.locale.to_s =~ /ko|ko_KR/i
        return Ununiga::JosaPicker.new(entry).takewell
      end
      entry
    end
  end
end
