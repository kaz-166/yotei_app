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
             .where("events.start_time::text LIKE ?",  "#{date.year}-#{prefix(date.month)}-#{prefix(date.day)}%")
      end
      private
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

