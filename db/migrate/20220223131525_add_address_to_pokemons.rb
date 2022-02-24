class AddAddressToPokemons < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :address, :string
  end
end
