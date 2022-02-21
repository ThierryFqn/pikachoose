class PokemonsController < ApplicationController
  def index
  end
  
  def new
  end

  def create
  end
  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :day_price, :height, :weight, :gender, :type, :personality, :description, :photo)
  end
end
