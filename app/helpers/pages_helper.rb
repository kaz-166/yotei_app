module PagesHelper

    # 指定された日にイベントが予定されているかを返すメソッド
    # [In] date: 日付(Datetime)
    # [Out] event_titles: 予定があるか(Boolean)
    # !!ヘルパメソッドは同じ入力に対して同じ出力を返すべき観点からこのロジックは要検討
    def has_event?(date)
        for event in @monthly_events do
            if (event.start_time.to_date <= date.to_date) &&
               (event.end_time.to_date >= date.to_date) 
                return true
            end
        end
        return false
    end

    # 指定された日のイベント名を返却するメソッド
    # [In] date: 日付(Datetime)
    # [Out] event_titles: イベント名(Str[])
    # !!ヘルパメソッドは同じ入力に対して同じ出力を返すべき観点からこのロジックは要検討
    def events_at_day(date)
        event_titles = []
        for event in @monthly_events do
            if (event.start_time.to_date <= date.to_date) &&
                (event.end_time.to_date >= date.to_date) 
                event_titles.push({:name => event.name, :time => event.start_time.strftime("%H:%M")})
            end
        end
        event_titles
    end
end


