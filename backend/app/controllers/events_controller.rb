class EventsController < ApplicationController
  def index
    @events = Event.all

    respond_to do |format|
      format.json { render json: @events.to_json(include: [:company, :room]) }
      format.html
    end
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.json { render json: @event.to_json }
      format.html
    end
  end

  def create
    @event = Event.new(
      name: params[:name],
      description: params[:description],
      start_time: Time.parse(params[:start_time]),
      end_time: Time.parse(params[:end_time]),
      event_type: params[:event_type],
      room: Room.find(params[:room_id]),
      company: params[:company_id].present? ? Company.find(params[:company_id]) : nil
      )
    @event.save!

    respond_to do |format|
      format.json { render json: @event.to_json }
      format.html
    end
  end

  def new
  end

  def destroy
  end
end
