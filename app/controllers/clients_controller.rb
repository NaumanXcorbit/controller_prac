class ClientsController < ApplicationController
  def index
    @clients = Client.all
    respond_to do |format|
      format.html
      format.xml {render xml: @clients}
      format.json {render json: @clients}
    end
  end
  def new
    @client = Client.new
  end
  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client
    else
      render "new"
    end
  end
  def show
    @client = Client.find(params[:id])
  end

  private
  def client_params
    params.require(:client).permit(:name,
                                   :about,
                                   :address,
                                   projects_attributes: [:name,
                                                         :about,
                                                         :price,
                                                         reviews_attributes: [:title,
                                                                              :description]])
  end
end
