class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end
  
  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:info] = "Room was successfuly created"
      redirect_to rooms_url
    else
      render 'new'
    end
  end

  private
  
    def room_params
      params.require(:room).permit(:name, :size, :room_type, :pax, :max_pax, :beds, :extra_beds, :bathrooms, :bathroom_type, :floor, :description)
    end

end















