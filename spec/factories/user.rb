FactoryBot.define do
    factory :user do
      username {"test"}
      email {"sample@example.com"}
      password {"foobar"}
      password_confirmation{"foobar"}
    end

  end