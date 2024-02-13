# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

elements = {
  fire: 'Strong against grass and ice, weak against water.',
  water: 'Strong against fire, weak against electricity.',
  electric: 'Strong against water, weak against ground.',
  ground: 'Strong against electric, weak against grass.',
  grass: 'Strong against ground, weak against fire.',
  ice: 'Strong against dragon, weak against fire.',
  dragon: 'Strong against dark, weak against ice.',
  dark: 'Strong against neutral, weak against dragon.',
  neutral: 'Weak against dark.'
}


elements.each do |name, description|
  Element.find_or_create_by!(name:, description:)
end

work_suitabilities = {
  kindling: 'Can heat campfires, cooking pots and industrial ovens.',
  watering: 'Can water plants, and power the crusher.',
  planting: 'Can sow seeds.',
  :"generating electricity" => 'Can power generators.',
  handiwork: 'Can do handiwork, such as crafting or building. Can also be put in factories to mass produce items.',
  gathering: 'Can gather crops from farms.',
  lumbering: 'Can gather lumber from trees.',
  mining: 'Can mine rocks, such as coal, surfur, ore, stone and paldium.',
  :"medicine production" => 'Can produce medicinal items.',
  cooling: 'Can cool refrigerators and similar devices.',
  transporting: 'Can transport items arounde the base.',
  farming: 'Can drop specific items when assigned to a ranch.'
}

work_suitabilities.each do |name, description|
  WorkSuitability.find_or_create_by!(name:, description:)
end

Rake::Task['pals:scrape'].invoke