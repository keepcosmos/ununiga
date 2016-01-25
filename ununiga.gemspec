Gem::Specification.new do |s|
  s.name        = 'ununiga'
  s.version     = '1.0.3'
  s.date        = '2016-01-25'
  s.summary     = 'Support Jaso and Josa(Korean Language specific function)'
  s.description = '한글 자소 분리 및 적절한 조사를 찾아주어 번역해줍니다.'
  s.authors     = ['Jaehyun Shin']
  s.email       = 'keepcosmos@gmail.com'
  s.files       = ['lib/ununiga.rb']
  s.homepage    = 'https://github.com/keepcosmos/ununiga'
  s.files       = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.add_development_dependency 'i18n'
  s.add_development_dependency 'minitest'
  s.license     = 'MIT'
end
