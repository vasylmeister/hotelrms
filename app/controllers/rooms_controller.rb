class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end
  
  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
    4.times {@room.bed_types.build}
  end
  
  #read comment_1 in Comments below
  def create
    @room = Room.new(room_params)
    if @room.save
      # && @room.bed_type_ids = params[:room][:bed_type_ids]
      @room.create_private_beds if @room.room_type == "shared"
      flash[:info] = "Room was successfuly created"
      redirect_to rooms_url
    else
      render 'new'
    end
  end
  
  def edit
    @room = Room.find(params[:id])
    @bed_types = @room.bed_types
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
      params.require(:room).permit(:name, :size, :room_type, :pax, :max_pax, :beds, :extra_beds, :bathrooms, :bathroom_type, :floor, :description, bed_types_attributes: [
        :id, :name, :width])
    end
  
    # def bed_type_params
    #   params.require(:bed_types).permit(options: params[:bed_types].keys) if params[:bed_types].any?
    # end


end


# Comments

# comment_1
# I create a room and associate bed types with it. 
# I wanted to do it the Rails way and create association automatically when Room is saved.
# I have almost managed to do it, when I reached an error. When getting bed_type_attributes, id, 
# it was trying to find an unexisting association of the unsaved room
# rails console output:
# params = {...}                                                                                                                                    
# => {:room=>{:name=>"110", :size=>"single", :room_type=>"private", :pax=>1, :max_pax=>1, 
# :beds=>1, :bathrooms=>1, :bathroom_type=>"private", :bed_types_attributes=>[{:id=>1}]}}
# rm = Room.create(params[:room])
# ActiveRecord::RecordNotFound: Couldn't find BedType with ID=1 for Room with ID=








