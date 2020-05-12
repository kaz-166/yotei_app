class PagesController < ApplicationController
  before_action :sign_in_required, only: [:show, :show_old]
  def index
    if user_signed_in?
      redirect_to '/pages/show'
    else
      redirect_to '/users/sign_in'
    end
  end

  def show
    # 今月のイベントで自分が主催者であるものを取得するクエリ カレンダー表示用
    # !! 自分が参加者となっているが主催者でないものは取得できないので要修正
    @monthly_events = Event.where("start_time LIKE ?",  "#{Date.today.year}-#{prefix(Date.today.month)}%")
                           .where("user_id = ?", "#{current_user.id}")
  end

  def show_old
  end

  private
    # 0～9ならば先頭に文字0を付加するメソッド
    def prefix(num)
      if (num >= 0) && (num <= 9)
        "0" + num.to_s
      else
        num.to_s
      end
    end
end
