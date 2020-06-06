FactoryBot.define do

  factory :recent_event, class: Event do
    user_id {1}
    name {"event"}
    start_time {Date.today()}
    end_time {Date.tomorrow()}
    location {"東京"}
    abstract {"東京"}
  end

  factory :past_event, class: Event do
    user_id {1}
    name {"event"}
    start_time {Date.today()}
    end_time {Date.tomorrow()}
    location {"東京"}
    abstract {"東京"}
  end

end