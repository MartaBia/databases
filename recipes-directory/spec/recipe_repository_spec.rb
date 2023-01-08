require 'recipe_repository'

RSpec.describe RecipeRepository do

  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_recipes_table
  end
  
  it "returns all the records" do
    repo = RecipeRepository.new
    recipes = repo.all

    expect(recipes.length).to eq 2

    expect(recipes[0].id).to eq "1"
    expect(recipes[0].name).to eq "Lasagne"
    expect(recipes[0].cooking_time).to eq "40"
    expect(recipes[0].rating).to eq "5"
  end

  it "returns 'Lasagne' when looking for id = 1" do
    repo = RecipeRepository.new

    recipe = repo.find(1)

    expect(recipe.id).to eq "1"
    expect(recipe.name).to eq 'Lasagne'
    expect(recipe.cooking_time).to eq "40"
    expect(recipe.rating).to eq "5"
  end
end