FactoryBot.define do
    factory :user, class: User do
      username {"test"}
      email {"sample@example.com"}
      password {"foobar"}
      password_confirmation{"foobar"}
      confirmed_at {"2020-2-12"}
    end

    factory :friend, class: User do
      username {"friend"}
      email {"sample2@example.com"}
      password {"foobar"}
      password_confirmation{"foobar"}
      confirmed_at {"2020-2-12"}
    end

  end