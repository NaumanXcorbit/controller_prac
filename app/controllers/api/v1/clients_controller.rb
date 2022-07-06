class Api::V1::ClientsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @clients = Client.all
    render json: @clients, status: 200
  end

  def create
    @client = Client.new(
      name: client_params[:name],
      about: client_params[:about],
      address: client_params[:address]
    )
    if @client.save
      render json: @client, :status => 200
    else
      render json: {error: "Something went wrong"}
    end
  end

  def show
    @client = Client.find_by(id:params[:id])
    if @client
    render json: @client, :status => 200
  else
    render json: {error: "client not fount"}
    end
  end

  private
  def client_params
    params.permit([:name, :about, :address, projects_attributes:[:name, :about, :price, reviews_attributes: [:title, :description ]]])
  end
end
