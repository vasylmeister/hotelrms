class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end
  
  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
    @bed_types = BedType.all
  end
  
  def create
    @room = Room.new(room_params)
    # @bed_type = BedType.find(params[:room][:bed_type_ids]) 
    if @room.save 
      # && @room.bed_types << @bed_type

      @room.create_private_beds if @room.room_type == "shared"
      flash[:info] = "Room was successfuly created"
      redirect_to rooms_url
    else
      render 'new'
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
  
    # def bed_type_params
    #   params.require(:bed_types).permit(options: params[:bed_types].keys) if params[:bed_types].any?
    # end

end















