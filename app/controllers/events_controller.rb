class EventsController < ApplicationController

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
    redirect_to "/pages/show"
  end

  def show
    @event = Event.find_by(id: params[:id])
    gon.location = @event.location
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.destroy
    redirect_to "/pages/show"
  end

  private
    def event_params
      params.require(:event).permit(:user_id, :name, :abstract, :start_time, :end_time, :location)
    end

end
