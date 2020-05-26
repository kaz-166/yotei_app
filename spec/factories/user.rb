FactoryBot.define do
    factory :user do
      username {"test"}
      email {"sample@example.com"}
      password {"foobar"}
      password_confirmation{"foobar"}
    end

    factory :event do
      user_id {1}
      name {"test"}
      start_time {Date.today}
      end_time {Date.today}
      location {"test_location"}
    end
  end