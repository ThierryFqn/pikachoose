class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :day_price, :height, :weight, :gender, :element, :personality, :description, :photo)
  end
end
