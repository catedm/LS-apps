require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"
require "pry"

before do
  @users = YAML.load_file('users.yaml')

  # GET TOTAL INTERESTS
  @total_interests = count_interests
end

helpers do

  def count_interests
    total = 0
    @users.values.each do |hash|
      hash.each do |key, value|
        key == :interests ? total += value.size : nil
      end
    end
    total
  end

end

get "/" do
  redirect "/users"
end

get "/users" do
  @name = "Bob"
  @address = ["123 Oak Street", "Portland", "Oregon", "97232"]
  erb :index
end

get "/:user_name" do
  @user_name = params[:user_name].to_sym
  @email = @users[@user_name][:email]
  @interests = @users[@user_name][:interests]
  erb :user
end
