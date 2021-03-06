# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "open-uri"
require "nokogiri"

puts 'Destroy All Pokemon'
Pokemon.destroy_all
puts 'Destroy all User'
User.destroy_all

puts 'create Meli'
User.create(first_name: 'Meli', last_name: 'cookie', email: 'cookie@gmail.com', password: '123456')
puts 'Create Sacha'
User.create(first_name: 'Sacha', last_name: 'Ketchum', email: 'sacha@gmail.com', password: '123456')

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123456"
  )
  puts 'Create 1 user'
end
puts 'Start scapping'

url = "https://www.pokemontrash.com/pokedex/liste-pokemon.php#gen1"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search(".pokedex").last.search("tbody > tr").first(25).each do |pokemon|
    name = pokemon.search('td')[2].text.strip
    element = pokemon.search('.type1').text.strip
    if Pokemon::FRENCH_POKEMON_TYPES.include?(element.downcase)
      index = Pokemon::FRENCH_POKEMON_TYPES.index(element.downcase)
      final_element = Pokemon::POKEMON_TYPES[index]
    end

    image_url = pokemon.search('td')[2].search('a').attribute('href').value
    img_file = URI.open("https://www.pokemontrash.com/pokedex/#{image_url}").read
    img_doc = Nokogiri::HTML(img_file)
    img_suffix = img_doc.search('#pokemon-image > img').attribute('src')
    img_pokemon = "https://www.pokemontrash.com/#{img_suffix}"
    pokemon = Pokemon.create!(
      user: User.all.sample,
      name: name,
      height: rand(1..200),
      weight: rand(1..100),
      day_price: rand(20..1000),
      gender: Pokemon::POKEMON_GENDERS.sample,
      element: final_element,
      personality: Pokemon::POKEMON_PERSONALITIES.sample,
      description: Faker::Emotion.adjective,
      address: Pokemon::POKEMON_CITY.shuffle!.pop
    )
    puts "Create #{pokemon.name} type: #{pokemon.element}, address: #{pokemon.address}"
    file = URI.open(img_pokemon)
    pokemon.photo.attach(io: file, filename: "#{name}.jpg", content_type: 'image/png')
end
