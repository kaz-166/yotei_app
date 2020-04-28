class EventsController < ApplicationController
  include EventsHelper
  before_action :sign_in_required, only: [:edit, :update, :show, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      add_participants_to_event(@event.id)
      redirect_to '/pages/show'
    else
      flash[:danger] = '入力情報が不正です!'
      redirect_to '/events/new'
    end
  end

  def edit 
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update(event_params)
      add_participants_to_event(params[:id])
      redirect_to "/pages/show"
    else
      flash.now[:danger] = '入力情報が不正です'
    end
  end

  def show
   
    @event = Event.find_by(id: params[:id])
    @post = Post.where(event_id: params[:id])
    #位置情報をJavaScriptに渡す
    gon.location = @event.location
    
    raise Forbidden unless ((current_user.id == @event.user_id) || (event_participants?(@event.id, current_user.id)))
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.destroy
    redirect_to "/pages/show"
  end

  private
    #Strong Parameters
    def event_params
      params.require(:event).permit(:user_id, :name, :abstract, :start_time, :end_time, :location, :add_ids => [])
    end

    #イベントの参加者を登録
    def add_participants_to_event(event_id)

      #[TODO]追加削除の処理に無駄があるので要最適化
      #まずすべて削除してから
      user = User.friend(current_user.id)
      unless user.empty?
        user.each do |u|
          Event.delete_user(event_id, u.id)
        end
      end
      #CheckBoxがオンのものを追加
      unless params[:add_ids] == nil
        params[:add_ids].each do |f_id|
          Event.add_user(event_id, f_id)
        end
      end
    end
end
