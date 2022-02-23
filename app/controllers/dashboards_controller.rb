class DashboardsController < ApplicationController
  def profile
    authorize(:dashboard, :profile?)
    @pokemons = current_user.pokemons
    @bookings = current_user.bookings
    @user = current_user
    @reserved_pokemons = Booking.all.each { |booking| booking.pokemon.user = current_user }
  end
end
