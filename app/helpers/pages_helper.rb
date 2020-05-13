module PagesHelper

    # 指定された日にイベントが予定されているかを返すメソッド
    # [In] day: 日付(Integer)
    # [Out] event_titles: 予定があるか(Boolean)
    # !!ヘルパメソッドは同じ入力に対して同じ出力を返すべき観点からこのロジックは要検討
    def has_event?(day)
        for event in @monthly_events do
            if event.start_time.day == day
                return true
            end
        end
        return false
    end

    # 指定された日のイベント名を返却するメソッド
    # [In] day: 日付(Integer)
    # [Out] event_titles: イベント名(Str[])
    # !!ヘルパメソッドは同じ入力に対して同じ出力を返すべき観点からこのロジックは要検討
    def events_at_day(day)
        event_titles = []
        for event in @monthly_events do
            if event.start_time.day == day
                event_titles.push({:name => event.name, :time => event.start_time.strftime("%H:%M")})
            end
        end
        event_titles
    end
end


