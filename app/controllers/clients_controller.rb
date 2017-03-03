class ClientsController < ApplicationController
  
  def index
    @clients = Client.not_deleted.all
  end
  
  def show
    @client = Client.find(params[:id])
  end
  
  def new
    @client = Client.new
    @client.cards.build
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

  def destroy
    @client = Client.find(params[:id]).destroy!
    flash[:success] = "Client was deleted"
    redirect_to clients_url
  end

  private
  
    def client_params
       params.require(:client).permit(:first_name, :last_name, :phone_number, :email, 
        cards_attributes: [:id, :card_name, :number, :card_type, :exp_month, :exp_year, :cvv])
    end
end
