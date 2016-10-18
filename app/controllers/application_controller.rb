class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Index
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # New
  get '/recipes/new' do
    erb :new
  end

  # Create
  post '/recipes' do
    @new_recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@new_recipe.id}"
  end

  # Show
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  # Edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    Recipe.update(@recipe.id, name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  # Delete
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end
end
