class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @pokemons = policy_scope(Pokemon).order(created_at: :desc)
    @markers = @pokemons.geocoded.map do |pokemon|
      {
        lat: pokemon.latitude,
        lng: pokemon.longitude,
        info_window: render_to_string(partial: "info_window", locals: { pokemon: pokemon }),
        image_url: helpers.asset_url("poke.png")
      }
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @user = @pokemon.user
    authorize @pokemon
  end

  def new
    @pokemon = Pokemon.new
    authorize @pokemon
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
    params.require(:pokemon).permit(:name, :day_price, :height, :weight, :gender, :element, :personality, :description, :photo, :address)
  end
end
