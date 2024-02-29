require 'ununiga/josa_picker'

module Ununiga::I18n
  module JosaTransformer
    def translate(locale, key, options = {})
      transform(super, key.end_with?("_html", ".html"), locale)
    end

    def transform(entry, is_html, locale=I18n.locale)
      if entry.is_a?(String) && locale.to_s =~ /ko|ko_KR/i
        return Ununiga::JosaPicker.new(entry, is_html).takewell
      end
      entry
    end
  end
end
