class LittleShopApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true


  get "/" do
    erb :"dashboard"
  end

  get "/merchants" do
    @merchants = Merchant.all
    erb :"merchants/index"
  end

  get "/merchants/new" do
    erb :"merchants/new"
  end

  get "/merchants/:id" do
    @merchant = Merchant.find(params[:id])
    erb :"merchants/show"
  end

  post "/merchants" do
    merchant = Merchant.new(params[:merchant])
    merchant.save
    redirect "/merchants"
  end

  get "/merchants/:id/edit" do
    @merchant = Merchant.find(params[:id])
    erb :"merchants/edit"
  end

  put "/merchants/:id" do |id|
    Merchant.update(id.to_i, params[:merchant])
    redirect "/merchants/#{id}"
  end

  delete "/merchants/:id" do |id|
    Merchant.destroy(id.to_i)
    redirect "/merchants"
  end

  get "/categories" do
    @categories = Category.all
    erb :"categories/index"
  end

  get "/categories/new" do
    erb :"categories/new"
  end

  get "/categories/:name" do
    @category = Category.find_by(name: params[:name])
    erb :"categories/show"
  end

  post "/categories" do
    category = Category.new(params[:category])
    category.save
    redirect "/categories"
  end

  get "/categories/:name/edit" do
    @category = Category.find_by(name: params[:name])
    erb :"categories/edit"
  end

  put "/categories/:name" do
    Category.update(params[:category][:id], params[:category])
    redirect "/categories/#{params[:category][:name]}"
  end

  delete "/categories/:name" do |name|
    category = Category.find_by(name: name)
    Category.destroy(category.id)
    redirect "/categories"
  end
end
