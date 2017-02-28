class ClientsController < ApplicationController
  
  def index
    @clients = Client.all
  end
  
  def show
    @client = Client.find(params[:id])
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:info] = "Client was successfuly added"
      redirect_to clients_url
    else
      render 'new'
    end
  end
  
  def edit
    @client = Client.find(params[:id])
  end
  
  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(client_params)
      flash[:success] = "Client was succesfully updated"
      redirect_to @client
    else
      render "edit.html.erb"
    end
  end



  private
  
    def client_params
       params.require(:client).permit(:first_name, :last_name, :phone_number, :email)
    end
end
