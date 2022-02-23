class BookingsController < ApplicationController

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
      flash[:notice] = 'Your request has been sent'
      redirect_to root_path
      # redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def accepted
    @booking = Booking.find(params[:id])
    @booking.status = Booking::BOOKING_STATUS[0]
    if @booking.save
      # a changer
      redirect_to root_path
    else
      # a changer
      render :new
    end
  end

  def denied
    @booking = Booking.find(params[:id])
    @booking.status = Booking::BOOKING_STATUS[1]
    # changer path
    @booking.save ? (redirect_to root_path) : (render :new)
  end

  def cancelled
    @booking = Booking.find(params[:id])
    @booking.status = Booking::BOOKING_STATUS[2]
    @booking.save ? (redirect_to root_path) : (render :new)
  end

  private

  def booking_params
    params.require(:booking).permit(:begin_date, :end_date, :status)
  end

  def booking_price(booking)
    (booking.end_date.to_date - booking.begin_date.to_date).to_i * booking.pokemon.day_price
  end
end
