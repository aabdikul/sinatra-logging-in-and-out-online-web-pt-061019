require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
require 'pry'

  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user != nil
      session[:user_id] = @user.id
      redirect '/account'
    elsif @user == nil
      erb :error
    end
  end

  get '/account' do
    if session[:user_id] != nil
    erb :account
    else
    erb :error
  end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

end
