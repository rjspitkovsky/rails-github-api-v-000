class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"], code: params[:code]}, {'Accept' => 'application/json'}
    body_hash = JSON.parse(resp.body)
    session[:token] = body_hash["access_token"]
  end
end
