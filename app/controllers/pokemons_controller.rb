class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @pokemons = policy_scope(Pokemon).order(created_at: :desc)

    if params[:search].present?
      # sql_query = "personality IN (:personalities) AND address ILIKE :address"

      @pokemons = policy_scope(Pokemon).order(created_at: :desc)
                                       .where(personality: search_params[:personalities])
                                      #  ajout adress lorsque migration OK
                                      # .where(address: search_params[:address])
      # @location = search_params[:address]
    else
      @pokemons = policy_scope(Pokemon).order(created_at: :desc)
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
    params.require(:pokemon).permit(:name, :day_price, :height, :weight, :gender, :element, :personality, :description, :photo)
  end

  def search_params
    params.require(:search).permit(:address, personalities:[])
  end
end
