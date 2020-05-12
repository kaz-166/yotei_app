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
    # 今月のイベントで自分が主催者であるもの
    # および自分が参加者であるものを取得するクエリ
    @monthly_events = Event.eager_load(:participants) #user_idをキーとして左外部結合
                           .where("events.start_time LIKE ?",  "#{Date.today.year}-#{prefix(Date.today.month)}%")
                           .where("events.user_id = ? OR participants.user_id = ?", "#{current_user.id}", "#{current_user.id}")
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
