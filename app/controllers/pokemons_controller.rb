class PokemonsController < ApplicationController
  def index
    @pokemons = policy_scope(Pokemon).order(created_at: :desc)
  end

  def new
    @pokemon = Pokemon.new
    authorize @pokemon
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @user = current_user
    @pokemon.user = @user
    authorize @pokemon
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
