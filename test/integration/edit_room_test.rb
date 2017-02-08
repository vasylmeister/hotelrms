require 'test_helper'

class EditRoomTest < ActionDispatch::IntegrationTest
  
  def setup
    @room = rooms(:room1)
    @shared_room = rooms(:room2)
  end

  test "should not update an invalid room" do
    get edit_room_path(@room)
    assert_response :success
    assert_template 'rooms/edit'
    assert_select '.page-header h1', "Edit room"
    patch room_path(@room), params: { room: {
        name: "201", 
        size: "single", 
        room_type: "",
        pax: 2, max_pax: 2, beds: 3, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 1}, '1': {id: 2, bed_type_id: 1}, '2': {id: 3, bed_type_id: 2}}}}
    assert_template 'rooms/edit'
    assert_select 'div#error_explanation'
  end
  
  test "should not update a valid room with wrong number of bed types" do
    get edit_room_path(@room)
    #change number of beds
    patch room_path(@room), params: { room: {
        name: "201", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 2, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 1}, '1': {id: 2, bed_type_id: 1}, '2': {id: 3, bed_type_id: 2}}}}
    assert_template 'rooms/edit', "Should not update the room with wrong number of bed types, beds changed"
    assert_select 'div#error_explanation'
    #change number of bed types by deleting
    patch room_path(@room), params: { room: {
        name: "201", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 3, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 1}, '1': {id: 2, bed_type_id: 1}, '2': {id: 3, bed_type_id: 2, _destroy: 1}}}}
    assert_template 'rooms/edit', "Should not update the room with wrong number of bed types, bed types deleted"
    assert_select 'div#error_explanation'
    #change number of bed types by adding new
    patch room_path(@room), params: { room: {
        name: "201", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 3, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 1}, '1': {id: 2, bed_type_id: 1}, '2': {id: 3, bed_type_id: 2}, '3': {bed_type_id: 2}}}}
    assert_template 'rooms/edit', "Should not update the room with wrong number of bed types, bed types added"
    assert_select 'div#error_explanation'
  end
  
  test "should not update a valid room with blank bed types" do
    get edit_room_path(@room)
    patch room_path(@room), params: { room: {
        name: "201", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 3, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 3}, '1': {id: 2, bed_type_id: 3}, '2': {id: 3, bed_type_id: ''}}}}
    # assert room.beds == room.bed_types.count, "Beds and bed_types should be equal"    
    assert_template 'rooms/edit', "Should not update the room with wrong number of bed types, bed types blank"
    assert_select 'div#error_explanation'
  end
  
  test "should update a valid room with valid private beds" do
    get edit_room_path(@room)
    patch room_path(@room), params: { room: {
        name: "301", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 3, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 1}, '1': {id: 2, bed_type_id: 1}, '2': {id: 3, bed_type_id: 2}}}}
    # assert @room.beds == @room.bed_types.count, "Beds and bed_types should be equal"
    assert_redirected_to room_url(@room)
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end
  
  test "should update a valid room with beds and bed types changed" do
    get edit_room_path(@room)
    patch room_path(@room), params: { room: {
        name: "201", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 4, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 1}, '1': {id: 2, bed_type_id: 1}, '2': {id: 3, bed_type_id: 2}, '3': {bed_type_id: 3}}}}
    # assert @room.beds == @room.bed_types.count, "Beds and bed_types should be equal"
    assert_redirected_to room_url(@room)
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end
  
  test "should update a valid room with bed types deleted" do
    get edit_room_path(@room)
    patch room_path(@room), params: { room: {
        name: "201", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 2, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 1}, '1': {id: 2, bed_type_id: 1}, '2': {id: 3, bed_type_id: 2, _destroy: 1}}}}
    # assert @room.beds == @room.bed_types.count, "Beds and bed_types should be equal"
    assert_redirected_to room_url(@room)
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end
  
  test "should update a valid room with bed types updated" do
    get edit_room_path(@room)
    patch room_path(@room), params: { room: {
        name: "201", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 3, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 3}, '1': {id: 2, bed_type_id: 3}, '2': {id: 3, bed_type_id: 2}}}}
    # assert @room.beds == @room.bed_types.count, "Beds and bed_types should be equal"
    assert_redirected_to room_url(@room)
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end

  test "should create private beds when type changes from private to shared" do
    get edit_room_path(@room)
    patch room_path(@room), params: { room: {
        name: "201", 
        size: "single", 
        room_type: "shared",
        pax: 2, max_pax: 2, beds: 3, bathrooms: 1, 
        bathroom_type: "shared",
        room_bed_types_attributes: {'0': {id: 1, bed_type_id: 3}, '1': {id: 2, bed_type_id: 3}, '2': {id: 3, bed_type_id: 2}}}}
    assert @room.private_beds.count == @room.beds, "Private beds count should be equal to the number of beds"
    assert_redirected_to room_url(@room)
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end

  test "should update private beds when type changes from shared to private" do
    get edit_room_path(@shared_room)
    patch room_path(@shared_room), params: { room: {
        name: "202", 
        size: "single", 
        room_type: "private",
        pax: 2, max_pax: 2, beds: 3, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 4, bed_type_id: 2}, '1': {id: 5, bed_type_id: 2}, '2': {id: 6, bed_type_id: 2}}}}
    assert @shared_room.private_beds.count == 0, "Private beds count should be zero"
    assert_redirected_to room_url(@shared_room)
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end
  
  test "should update private beds when the number of beds changes" do
    get edit_room_path(@shared_room)
    patch room_path(@shared_room), params: { room: {
        name: "202", 
        size: "single", 
        room_type: "shared",
        pax: 2, max_pax: 2, beds: 2, bathrooms: 1, 
        bathroom_type: "private", 
        room_bed_types_attributes: {'0': {id: 4, bed_type_id: 2}, '1': {id: 5, bed_type_id: 2}, '2': {id: 6, bed_type_id: 2, _destroy: 1}}}}
    assert @shared_room.private_beds.count == @shared_room.reload.beds, "Private beds count should be equal to the number of beds"
    assert_redirected_to room_url(@shared_room)
    follow_redirect!
    assert_not flash.empty?, "Should be a flash message"
  end
  
end
