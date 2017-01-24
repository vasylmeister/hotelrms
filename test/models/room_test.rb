require 'test_helper'

class RoomTest < ActiveSupport::TestCase

  def setup
    @room = Room.new(name: "101", size: "single room", room_type: "private", pax: 1, max_pax: 2, beds: 1, bathrooms: 1, bathroom_type: "private")
  end
  
  test "should be valid" do
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
  
  test "room_type should be present" do
    @room.room_type = ""
    assert_not @room.valid?
  end  
  
  test "capacity should be present" do
    @room.pax = nil
    assert_not @room.valid?
  end
  
  test "max capacity max_pax should be present" do
    @room.max_pax = nil
    assert_not @room.valid?
  end
  
  test "number of beds should be present" do
    @room.beds = nil
    assert_not @room.valid?
  end
  
  test "number of bathrooms should be present" do
    @room.bathrooms = nil
    assert_not @room.valid?
  end
  
  test "type of bathroom should be present" do
    @room.bathroom_type = ""
    assert_not @room.valid?
  end
  

  
  
  
end
