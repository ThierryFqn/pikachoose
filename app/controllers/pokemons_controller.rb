class PokemonsController < ApplicationController
  def index
    @pokemons = policy_scope(Pokemon).order(created_at: :desc)
  end

  def new
    authorize @pokemon
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = current_user
    authorize @pokemon
    @user = current_user
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = @user
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
