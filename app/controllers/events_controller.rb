class EventsController < ApplicationController

before_action :set_event, :only => [ :show, :edit, :update, :destroy]

def index
  # @events = Event.all
  @events = Event.page(params[:page]).per(5)
end

def new
  @event = Event.new
end

# def create
#   @event = Event.new( :name => params[:event][:name] )
#   @event.save

#   redirect_to :action => :index
# end

def create
  @event = Event.new(event_params)

  if @event.save
    redirect_to event_url
    flash[:notice] = "event was successfully created"
  else
    render :action => :new
  end
end

def show
	@page_title = @event.name
end

def edit
	# flash[:notice] = "event was successfully edited"
end

def update
  if @event.update_attributes(event_params)
    redirect_to event_url(@event) 
    flash[:notice] = "event was successfully updated"
  else
    render :action => :edit
  end
end

def destroy
  @event.destroy

	flash[:alert] = "event was successfully deleted"
  redirect_to event_url
end

private

def set_event
  @event = Event.find(params[:id])
end

def event_params
  params.require(:event).permit(:name, :description)
end

end
