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
end
