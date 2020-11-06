class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  def index
    # @events = Event.all
    @events = Event.page params[:page]
    @upcoming_events = Event.upcoming.page params[:page]
    @past_events = Event.past.page params[:page]

  end

  def show 
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:notice] = 'Your event was successfully created'
      redirect_to events_path
    else
      render 'new'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_datetime, :end_datetime)
  end
end