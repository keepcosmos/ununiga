require 'minitest/autorun'
require 'i18n'
require 'ununiga/i18n/josa_transformer'

class JosaTransformerTest < Minitest::Test
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

  def test_transform_korean_with_html
    assert_equal '<b>철수</b>가 돈을 냅니다.', I18n.t(:someone_pay_html, name: '철수')
    assert_equal '<b>재현</b>이 돈을 냅니다.', I18n.t(:someone_pay_html, name: '재현')

    assert_equal '<b>호랑이</b>는 <b>사과</b>를 먹습니다.', I18n.t("someone_eat_nesting.html", name: '호랑이', meal: '사과')
    assert_equal '<b>곰</b>은 <b>마늘</b>을 먹습니다.', I18n.t("someone_eat_nesting.html", name: '곰', meal: '마늘')
  end

  def test_not_string_locale_value
    assert_equal 234.234234, I18n.t(:float_value)
    assert_equal ({ first: '1', second: '2' }), I18n.t(:nested_value)
  end

  def test_not_convert_start_with_ununiga
    assert_equal "이(가) 시작합니다.", I18n.t(:start_with_ununiga)
  end
end
