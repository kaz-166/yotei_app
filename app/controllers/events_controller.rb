class EventsController < ApplicationController
  include EventsHelper
  before_action :sign_in_required, only: [:edit, :update, :show, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    start_time, end_time = integrated_event_datetime
    @event.start_time = start_time
    @event.end_time = end_time
    @event.user_id = current_user.id
    if @event.save
      add_participants_to_event(@event.id)
      redirect_to(pages_show_path)
    else
      flash[:danger] = '入力情報が不正です!'
      redirect_to(new_event_path)
    end
  end

  def edit 
    @event = Event.find_by(id: params[:id])
    # 予定の管理者の場合のみ編集を許可
    raise Forbidden unless current_user.id == @event.user_id
  end

  def update
    @event = Event.find_by(id: params[:id])

    start_time, end_time = integrated_event_datetime
    @event.start_time = start_time
    @event.end_time = end_time
    if @event.update(event_params)
      add_participants_to_event(params[:id])
      redirect_to(pages_show_path)
    else
      flash.now[:danger] = '入力情報が不正です'
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    @post = Post.where(event_id: params[:id])
    # 位置情報をJavaScriptに渡す
    gon.location = @event.location
    
    raise Forbidden unless ((current_user.id == @event.user_id) || (event_participants?(@event.id, current_user.id)) || (@event.open_range == "public_range"))
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.destroy
    redirect_to(pages_show_path)
  end

  private
    # ストロングパラメータの設定
    def event_params
      params.require(:event).permit(:user_id, :name, :abstract, 
                                    :start_time, :end_time, 
                                    :start_time_date, :start_time_hour, :start_time_minute,
                                    :end_time_date, :end_time_hour, :end_time_minute,
                                    :open_range, :location, :add_ids => [])
    end

    def integrated_event_datetime
      st_date = event_params[:start_time_date].split("-")
      st_time = Time.new(st_date[0].to_i, st_date[1].to_i, st_date[2].to_i, event_params[:start_time_hour].to_i, event_params[:start_time_minute].to_i, 0).in_time_zone(Time.zone.tzinfo.identifier)
      ed_date = event_params[:end_time_date].split("-")
      ed_time = Time.new(ed_date[0].to_i, ed_date[1].to_i, ed_date[2].to_i, event_params[:end_time_hour].to_i, event_params[:end_time_minute].to_i, 0).in_time_zone(Time.zone.tzinfo.identifier)
      return st_time, ed_time
    end

    # イベントの参加者を登録するメソッド
    # [In] event_id: イベントID(Integer)
    def add_participants_to_event(event_id)
      # [TODO]追加削除の処理に無駄があるので要最適化
      # まずすべて削除してから
      user = User.friend(current_user.id)
      unless user.empty?
        user.each do |u|
          Event.delete_user(event_id, u.id)
        end
      end
      # CheckBoxがオンのものを追加
      unless params[:add_ids] == nil
        params[:add_ids].each do |f_id|
          Event.add_user(event_id, f_id)
        end
      end
    end
end
