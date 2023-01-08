require_relative 'lib/database_connection.rb'
require_relative 'lib/recipe_repository'

DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

recipe_repository.all.each do |recipe|
  puts "#{recipe.id}- #{recipe.name}, cooking time:#{recipe.cooking_time},  rating:#{recipe.rating}"
end

recipe = recipe_repository.find(1)
puts "#{recipe.name}, cooking time:#{recipe.cooking_time},  rating:#{recipe.rating}"