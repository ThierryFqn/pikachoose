class BookingsController < ApplicationController

  def show
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking.pokemon = @pokemon
    @booking.user = current_user
    @booking.total_price = booking_price(@booking)
    authorize @booking
    authorize @pokemon
    if @booking.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:begin_date, :end_date, :status)
  end

  def booking_price(booking)
    (booking.end_date - booking.begin_date) * booking.pokemon.price
  end
end
