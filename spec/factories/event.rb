FactoryBot.define do

  factory :recent_event, class: Event do
    user_id {1}
    name {"sample event"}
    start_time {"2030-1-12"}
    end_time {"2030-1-17"}
    location {"東京"}
    abstract {"東京"}
  end

  factory :past_event, class: Event do
    user_id {1}
    name {"event"}
    start_time {"1992-2-12"}
    end_time {"1992-2-15"}
    location {"東京"}
    abstract {"東京"}
  end

end