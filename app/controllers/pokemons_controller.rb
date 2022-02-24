class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @pokemons = policy_scope(Pokemon).order(created_at: :desc)

    if params[:search].present?
      # sql_query = "personality IN (:personalities) AND address ILIKE :address"

      @pokemons = policy_scope(Pokemon).order(created_at: :desc)
                                       .where(personality: search_params[:personalities])
                                       .where(address: search_params[:address].capitalize)
      @location = search_params[:address]
    else
      @pokemons = policy_scope(Pokemon).order(created_at: :desc)
    end

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
    @booking = Booking.new
    @booking.pokemon = @pokemon
    authorize @booking
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
    if @pokemon.save
      redirect_to pokemon_path(@pokemon)
    else
      render :new
    end
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
    authorize @pokemon
  end

  def update
    @pokemon = Pokemon.find(params[:id])
    @pokemon.update(pokemon_params)
    authorize @pokemon
    redirect_to pokemon_path(@pokemon)
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy
    authorize @pokemon
    redirect_to dashboards_path
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :day_price, :height, :weight, :gender, :element, :personality, :description, :photo, :address)
  end

  def search_params
    params.require(:search).permit(:address, personalities:[])
  end
end
