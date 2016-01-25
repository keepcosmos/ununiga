require 'minitest/autorun'
require 'ununiga/josa_picker'
require 'ununiga/i18n/josa_transformer'
require 'i18n'

class JosaTransformerTest < Minitest::Unit::TestCase
  def setup
    super
    I18n::Backend::Simple.send(:include, Ununiga::I18n::JosaTransformer)
    I18n.load_path = [File.dirname(__FILE__) + '/test.yml']
    I18n.available_locales = [:en, :ko, :ko_KR]
    I18n.locale = :ko
  end
  
  def test_transform_korean
    assert_equal '철수가 돈을 냅니다.', I18n.t(:someone_pay, name: '철수')
    assert_equal '재현이 돈을 냅니다.', I18n.t(:someone_pay, name: '재현')

    assert_equal '호랑이는 사과를 먹습니다.', I18n.t(:someone_eat_something, name: '호랑이', meal: '사과')
    assert_equal '곰은 마늘을 먹습니다.', I18n.t(:someone_eat_something, name: '곰', meal: '마늘')

    assert_equal '재현과 진아는 개발을 합니다.', I18n.t(:do_something_with_someone, name1: '재현', name2: '진아', doing: '개발')
    assert_equal '정하와 민정은 디자인을 합니다.', I18n.t(:do_something_with_someone, name1: '정하', name2: '민정', doing: '디자인')
  end

  
end
