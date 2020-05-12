module PagesHelper

    # 指定された日にイベントが予定されているかを返すメソッド
    # !!ヘルパメソッドは同じ入力に対して同じ出力を返すべきとの観点からこのロジックは要検討
    def has_event?(day)
        for event in @monthly_events do
            if event.start_time.day == day
                return true
            end
        end
        return false
    end
end


