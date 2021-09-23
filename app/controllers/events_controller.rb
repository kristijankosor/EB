class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    def index
        @events = Event.all
    end

    def show
    end

    def new
        @event = Event.new
    end

    def create 
        @event = Event.new(event_params)
        if @event.save
            flash[:notice] = "Event created for event " + event_params[:title]
            redirect_to @event
        else
            flash.now[:alert] = "Event not created"
            render "new"
        end
    end
   
    def edit
    end

    def update
        if @event.update(event_params)
            flash[:notice] = "Event updated!"
            redirect_to @event
        else
            flash.now[:alert] = "Event not updated!"
            render "edit"
        end

    end

    def destroy
        if @event.destroy
            flash[:notice] = "Event deleted successfully!"
            redirect_to events_path(@events)
        else
            flash.now[:alert] = "Event is not deleted!"
            render "edit"
        end
    end
    
    private
        def set_event 
            @event = Event.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            flash[:alert] = "The page you requested does not exist"
            redirect_to events_path
        end

        def event_params
            params.require(:event).permit(:title, :description, :start_date, :end_date, :venue, :location)
        end
    
end
