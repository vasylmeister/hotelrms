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
      @room.create_private_beds if @room.room_type == "shared"
      flash[:info] = "Room was successfuly created"
      redirect_to rooms_url
    else
      render 'new'
    end
  end
  
  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(room_params)
      
      flash[:success] = "Room updated"
      redirect_to @room
    else
      render 'edit'
    end
  end
  
  def destroy
    @room = Room.find(params[:id]).destroy
    flash[:success] = "Room deleted"
    redirect_to rooms_url
  end
  
  
  private
  
    def room_params
      params.require(:room).permit(:name, :size, :room_type, :pax, :max_pax, :beds, :extra_beds, :bathrooms, :bathroom_type, :floor, :description)
    end

end















