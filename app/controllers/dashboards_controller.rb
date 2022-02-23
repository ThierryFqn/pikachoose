class DashboardsController < ApplicationController
  def profile
    authorize(:dashboard, :profile?)
    @pokemons = current_user.pokemons
    @bookings = current_user.bookings
    @user = current_user
    @reserved_pokemons = Booking.all.select { |booking| booking.pokemon.user == @user }
  end
end
