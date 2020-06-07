FactoryBot.define do
    factory :user do
      username {"test"}
      email {"sample@example.com"}
      password {"foobar"}
      password_confirmation{"foobar"}
      confirmed_at {"2020-2-12"}
    end

  end