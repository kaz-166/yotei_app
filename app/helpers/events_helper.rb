require 'active_support/time' 

module EventsHelper
    # 指定されたイベントが終了したかを返すメソッド
    def event_finished?(event)
        Time.current > event.end_time
    end

    # イベントの参加者かどうかを返すメソッド
    def event_participants?(event_id, user_id)
        if (event_id != nil) && (user_id != nil)
            Participant.where(event_id: event_id, user_id: user_id).exists?
        else
            false
        end
    end

        # 0～9ならば先頭に文字0を付加するメソッド(Integer -> Str)
    # [In] 0～12の数字(Integer)
    # [Out] プレフィクスが付加された文字列(Str)
    def prefix(num)
        if (num >= 0) && (num <= 9)
          "0" + num.to_s
        else
          num.to_s
        end
    end
end
