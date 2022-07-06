class ClientsController < ApplicationController
  force_ssl
  # http_basic_authenticate_with name: "admin", password: "1122"

  # before_action :authenticate
  def download_pdf
    client = Client.find(params[:id])
    send_file("#{Rails.root}/files/clients/#{client.id}.pdf",
              filename: "#{client.name}.pdf",
              type: "application/pdf")
  end
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
  def authenticate
    authenticate_or_request_with_http_digest name: "admin", password: "1122"
  end

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
