include EventsHelper
class UserMailer < ApplicationMailer

    def remind(user)
      @user = user
      if has_recent_events?(@user.id).empty?
      else
        @text_html = "おはようございます。"+ @user.username + "さん。本日は以下の予定があります。<br>"
        @events.each do |e|
          @text_html += "予定名：" + e.name + "     開始時間：" + e.start_time.to_s + "<br>"
        end
        mail to: "#{@user.email}", subject: "[Yotei-App] 本日の予定"
      end
    end 

    private
      def has_recent_events?(user_id)
        date = Date.today
        @events = Event.eager_load(:participants)
             .where("events.user_id = ? OR participants.user_id = ?", user_id, user_id)
             .where("events.start_time::text LIKE ?",  "#{date.year}-#{PagesHelper.prefix(date.month)}-#{PagesHelper.prefix(date.day)}%")
      end

end

