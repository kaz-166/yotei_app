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
    if params[:start_date] == nil
      date = Date.today
    else
      date = Date.parse(params[:start_date])
    end
    @events = Event.eager_load(:participants)
                   .where("events.user_id = ? OR participants.user_id = ? OR events.open_range = 1", "#{current_user.id}", "#{current_user.id}")
                   .where("events.end_time >= ?", "#{Date.today}")
                   .order(start_time: 'ASC')
    @events = Kaminari.paginate_array(@events).page(params[:page]).per(Settings.post.pagenation)
    # (指定された月のイベント) AND ((自分が主催者であるもの) OR (自分が参加者であるもの))
    # を取得するクエリ
    # @monthly_events: カレンダー表示時に使用するインスタンス変数
    @monthly_events = Event.eager_load(:participants) # user_idをキーとして左外部結合
                             .where("events.start_time <= ? OR events.end_time >= ?",  "#{date}", "#{date}")
                             .where("events.user_id = ? OR participants.user_id = ?", "#{current_user.id}", "#{current_user.id}")
  end

  def show_old
    @events = Event.eager_load(:participants)
    .where("events.user_id = ? OR participants.user_id = ? OR events.open_range = 1", "#{current_user.id}", "#{current_user.id}")
    .where("events.end_time < ?", "#{Date.today}")
    .order(start_time: 'DESC')
    @events = Kaminari.paginate_array(@events).page(params[:page]).per(Settings.post.pagenation)
  end

  private
    # 0～9ならば先頭に文字0を付加するメソッド(Integer -> Str)
    # [In] 0～12の数字(Integer)
    # [Out] プレフィクスが付加された文字列(Str)
    def prefix(num)
      if (num >= 0) && (num <= 9)
        '0' + num.to_s
      else
        num.to_s
      end
    end
end
