class BookingsController < ApplicationController

  def index
    @bookings = policy_scope(Booking).order(created_at: :desc)
  end

  def new
    @booking = Booking.new
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking.pokemon = @pokemon
    authorize @booking
    authorize @pokemon
  end

  def create
    @booking = Booking.new(booking_params)
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking.pokemon = @pokemon
    @booking.user = current_user
    @booking.status = Booking::BOOKING_STATUS[3]
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
    (booking.end_date.to_date - booking.begin_date.to_date).to_i * booking.pokemon.day_price
  end
end
