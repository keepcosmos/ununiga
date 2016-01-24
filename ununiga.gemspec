Gem::Specification.new do |s|
  s.name        = 'ununiga'
  s.version     = '0.1.0'
  s.date        = '2015-07-26'
  s.summary     = 'support Josa(Korean Language specific function) on rails-i18n'
  s.description = 'Rails에서 i18n을 사용할 때 적합한 한글의 조사를 찾아주어 번역합니다.'
  s.authors     = ['keepcosmos']
  s.email       = 'keepcosmos@gmail.com'
  s.files       = ['lib/ununiga.rb']
  s.add_development_dependency 'i18n', '~> 0.7'
  s.homepage    = 'http://rubygems.org/gems/hola'
  s.license     = 'MIT'
end
