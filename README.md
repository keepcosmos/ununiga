[![Build Status](https://travis-ci.org/keepcosmos/ununiga.svg?branch=master)](https://travis-ci.org/keepcosmos/ununiga)
작성중 ...
# ununiga[은는이가]

은는이가는 한글의 자소분리를 분리하고 조사를 찾아주는 역할을 합니다.  
I18n의 Backend 모듈도 제공합니다.

## Installation
```
gem install ununiga
```

### 조사 찾기
```ruby
require 'ununiga'

Ununiga::JosaPicker.takewell("레일즈와(과) 쟝고은(는) 싸우지 않습니다.")
# => "레일즈와 쟝고는 싸우지 않습니다."
Ununiga::JosaPicker.takewell("트위터(으)로 로그인합니다.")
# => "페이스북로 로그인합니다."

picker = Ununiga::JosaPicker.new("레일즈은(는) 루비을(를) 사용합니다.")
picker.takewell
# => "레일즈는 루비를 사용합니다.

picker.josas
# => [[3, ["은", "는"]], [10, ["을", "를"]]]
``` 

### I18n에 적용하기
1. Gemfile에 ununiga를 추가합니다. 
```
gem 'ununiga'
```

2. Initializer나 environment config파일에 아래 코드를 추가합니다.
```ruby
I18n::Backend::Simple.send(:include, Ununiga::I18n::JosaTransformer)
```

3. 한글 locale yml 파일에 조사를 사용하는 부분을 찾아 '은(는)|(는)은|을(를)...'등으로 조사를 변경합니다.
```yaml
links:
  sign_in_with_provider: "%{provider}(으)로 로그인"

# Rails의 ActiveModel/ActiveRecord의 Validation을 사용할 경우
errors:
  # 디폴트는 `%{attribute} %{message}`형식으로 띄워쓰기가 되어 있으며로 format을 붙여쓰기로 변경해줍니다.
  foramt: "%{attribute}%{message}"
  messages:
    accepted: 을(를) 반드시 확인해야 합니다.
    equal_to: 은(는) %{count}와(과) 같아야 합니다
```

## Test
두가지 방식으로 테스트 할 수 있습니다.
* `rake test` 혹은 그냥 `rake` 커맨드를 사용합니다.
* 특정 파일을 테스트할 경우 `ruby -Ilib:test /test/{file_name}` 을 사용합니다.

