class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"], code: params[:code]}, {'Accept' => 'application/json'})
    body = JSON.parse(resp.body)
    session[:token] = body['access_token']

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to root_path
  end
end




# class ApplicationController < ActionController::Base
#   # Prevent CSRF attacks by raising an exception.
#   # For APIs, you may want to use :null_session instead.
#   protect_from_forgery with: :exception
#   before_action :authenticate_user
#
#   private
#
#     def authenticate_user
#       # make sure to pass in the scope parameter (`repo` scope should be appropriate for what we want to do) in step of the auth process!
#       # https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/#web-application-flow
#       client_id = ENV['CLIENT_ID']
#       # redirect_uri = CGI.escape("http://localhost:3000/auth")
#       github_url = 'https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=repo'
#       redirect_to github_url unless logged_in?
#
#     end
#
#     def logged_in?
#       !!session[:token]
#     end
#
# end
