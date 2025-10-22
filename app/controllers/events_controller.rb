class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @events = Event.visible_to(current_user)
  end


  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find()
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    redirect_to events_path, alert: 'Not authorized' unless @event.creator == current_user
  end

  def event_params
    params.require(:event).permit(:date, :location, :private)
  end
end
