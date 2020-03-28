class EventsController < ApplicationController
  before_action :sign_in_required, only: [:edit, :update, :show, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.save
    redirect_to '/pages/show'
  end

  def edit 
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    @event.update(event_params)

    unless params[:friend_ids] == nil
      params[:friend_ids].each do |f_id|
        Event.add_user(params[:id], f_id)
      end
    end
    redirect_to "/pages/show"
  end

  def show
    @event = Event.find_by(id: params[:id])
    #位置情報をJavaScriptに渡す
    gon.location = @event.location
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.destroy
    redirect_to "/pages/show"
  end

  private
    #Strong Parameters
    def event_params
      params.require(:event).permit(:user_id, :name, :abstract, :start_time, :end_time, :location, :friend_ids => [])
    end

end
