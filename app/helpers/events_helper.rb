require 'active_support/time' 

module EventsHelper
    #指定されたイベントが終了したか?
    def event_finished?(event)
        Time.current > event.end_time
    end
end
