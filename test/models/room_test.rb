require 'test_helper'

class RoomTest < ActiveSupport::TestCase

  def setup
    @room = Room.new(name: "101", size: "single", room_type: "private", pax: 2, max_pax: 2, beds: 1, bathrooms: 1, bathroom_type: "private", 
    bed_types_attributes: {'0': {id: 1 }})
    @shared_room = Room.new(name: "102", size: "cuadruple room", room_type: "shared", pax: 1, max_pax: 2, beds: 1, bathrooms: 1, bathroom_type: "shared",
    bed_types_attributes: {'0': {id: 3 }})
  end
  
  test "room should be valid" do
    assert @room.valid?
  end
  
  test "name should be present" do
    @room.name = ""
    assert_not @room.valid?
  end
  
  test "name should be unique" do
    duplicated_room = @room.dup
    @room.save
    assert_not duplicated_room.valid?
  end

  test "name should not be too long" do
    @room.name = "1" * 9
    assert_not @room.valid?
  end  
  
  
  test "size should be present" do
    @room.size = ""
    assert_not @room.valid?
  end  
  
  test "size should be a valid size" do
    @room.size = "king"
    assert_not @room.valid?
  end 
  
  # testing group validations for room_type and bathroom_type
  test "room_type should be present" do
    @room.room_type = ""
    assert_not @room.valid?
  end  
  
  test "room_type should be a valid type" do
    @room.room_type = "friendly"
    assert_not @room.valid?
  end 
  
  # testing group validations for pax, max_pax, beds, bathrooms
  test "capacity should be present" do
    @room.pax = nil
    assert_not @room.valid?
  end
  
  test "capacity should be a number" do
    @room.pax = 'b'
    assert_not @room.valid?
  end  
  
  test "capacity should be an integer" do
    @room.pax = 2.5
    assert_not @room.valid?
  end    
  
  test "capacity should be greater than 0" do
    @room.pax = 0
    assert_not @room.valid?
  end

  test "capacity should not be greater than 10" do
    @room.pax = 0
    assert_not @room.valid?
  end
  
  test "max capacity should not be less than capacity" do
    @room.max_pax = 1
    assert_not @room.valid?
  end
  
  # testing group validations for floor and extra_beds
  test "floor should be a number" do
    @room.pax = 'b'
    assert_not @room.valid?
  end  
  
  test "floor should be an integer" do
    @room.floor = 2.2
    assert_not @room.valid?
  end
  
  # test "shared room should the same number of beds and private beds records" do
  #   assert_equal(@shared_room.beds, @shared_room.private_beds.count)
  # end
  
end