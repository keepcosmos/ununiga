require 'ununiga/version'

module Ununiga
  autoload :JasoSplitter, 'ununiga/jaso_splitter'
  autoload :JosaPicker, 'ununiga/josa_picker'
  
  module I18n
    autoload :JosaTransformer, 'ununiga/i18n/josa_transformer'
  end
end
