require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  def setup
    @client = Client.new(first_name: "Jack", last_name: "Sparrow", phone_number: "+9876543211", email: "jack@fakemail.com")
  end
  
  test "client should be valid" do
    assert @client.valid?
  end
  
  test "first_name should be present" do
    @client.first_name = ""
    assert_not @client.valid?
  end
  
  test "last_name should be present" do
    @client.last_name = ""
    assert_not @client.valid?
  end

  test "first_name should not be too long" do
    @client.first_name = "A" * 129
    assert_not @client.valid?
  end  
  
  test "last_name should not be too long" do
    @client.last_name = "A" * 129
    assert_not @client.valid?
  end  
  
  
  test "phone_number should be present" do
    @client.phone_number = ""
    assert_not @client.valid?
  end
  
  test "phone_number should be valid" do
    @client.phone_number = "invalid phone number"
    assert_not @client.valid?
  end
  
  test "phone_number should be unique" do
    dupplicated_client = @client.dup
    @client.save
    assert_not dupplicated_client.valid?
  end  

  test "email should be present" do
    @client.email = ""
    assert_not @client.valid?
  end 
  
  test "email should be valid" do
    @client.email = "invalid email"
    assert_not @client.valid?
  end  
  
  test "email should be unique" do
    dupplicated_client = @client.dup
    @client.save
    assert_not dupplicated_client.valid?
  end 
  
end
