class DashboardsController < ApplicationController
  def profile
    authorize(:dashboard, :profile?)
    @pokemons = current_user.pokemons
    @bookings = current_user.bookings
    @user = current_user
    @booking_pokemons_user = Booking.all.select { |booking| booking.pokemon.user == @user }
    @demand_pending_user = select("pending")
    @demand_accepted_user = select("accepted")
  end

  def my_profile
    skip_authorization
  end

  private

  def select(state)
    @booking_pokemons_user.select { |booking| booking.user != current_user && booking.status == state }
  end
end
