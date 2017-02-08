require 'test_helper'

class CreateRoomTest < ActionDispatch::IntegrationTest
  
  test "should not create an invalid room with no bed types" do
    get new_room_path
    assert_response :success
    assert_template 'rooms/new'
    assert_select '.page-header h1', "Create new room"
    assert_no_difference 'Room.count' do
      post rooms_path, params: {room: {
        name: "", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 1, bathrooms: 1, 
        bathroom_type: "private", 
        bed_types_attributes: {}}}
    end
    assert_template 'rooms/new'
  end
  
  test "should not create a valid room with no bed types" do
    get new_room_path
    assert_no_difference 'Room.count' do
      post rooms_path, params: {room: {
        name: "101", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 1, bathrooms: 1, 
        bathroom_type: "private", 
        bed_types_attributes: {}}}
    end
    assert_template 'rooms/new'
  end
  
  test "should not create a valid room with invalid number of bed types" do
    get new_room_path
    assert_no_difference 'Room.count' do
      post rooms_path, params: { room: {
        name: "101", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 1, bathrooms: 1, 
        bathroom_type: "private", 
        bed_types_attributes: {'0': {id: 1}, '1': {id: 2}}}}
    end
    assert_template 'rooms/new'
  end
  
  test "should create a valid room with valid number of bed_types" do
    get new_room_path
    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: {
        name: "101", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 2, bathrooms: 1, 
        bathroom_type: "private", 
        bed_types_attributes: {'0': {id: 1}, '1': {id: 1}}}}
    end
    room = assigns(:room)
    assert room.beds == room.bed_types.count, "Beds and bed types should be equal"
    assert_redirected_to rooms_url
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end
  
  test "should discard blank bed types for a valid room" do
    get new_room_path
    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: {
        name: "101", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 2, bathrooms: 1, 
        bathroom_type: "private", 
        bed_types_attributes: {'0': {id: 1}, '1': {id: 1}, '2': {}}}}
    end
    room = assigns(:room)
    assert room.beds == room.bed_types.count, "Beds and bed types should be equal"
    assert_redirected_to rooms_url
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end
  
  test "should create a valid shared room with correct number of private beds" do
    get new_room_path
    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: {
        name: "101", 
        size: "single", 
        room_type: "shared",
        pax: 2, max_pax: 2, beds: 2, bathrooms: 1, 
        bathroom_type: "private", 
        bed_types_attributes: {'0': {id: 1}, '1': {id: 1}}}}
    end
    room = assigns(:room)
    assert room.beds == room.private_beds.count, "Shared room should have private beds equal to the number of beds"
    assert_redirected_to rooms_url
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end
  
  test "should not create private beds for private room type" do
    get new_room_path
    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: {
        name: "101", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 2, bathrooms: 1, 
        bathroom_type: "private", 
        bed_types_attributes: {'0': {id: 1}, '1': {id: 1}}}}
    end
    room = assigns(:room)
    assert room.private_beds.count == 0, "Private room should not have private beds"
    assert_redirected_to rooms_url
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end
  
end
