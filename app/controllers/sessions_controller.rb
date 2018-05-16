class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create


  def create
    resp = Faraday(:post, "https://github.com/login/oauth/access_token").
         with(:body => {"client_id"=>"Iv1.a4ca637fbd533914", "client_secret"=>"feb5be490850317508dada7a906f4d263638516d", "code"=>"2
0"},
              :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type
'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.9.1'}).
         to_return(:status => 200, :body => "", :headers => {})
    # resp = Faraday.post("https://github.com/login/oauth/access_token", {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"], code: params[:code]}, {'Accept' => 'application/json'})
    body = JSON.parse(resp.body)
    session[:token] = body['access_token']

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to root_path

    # resp = Faraday.post('https://github.com/login/oauth/access_token', {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"], code: params[:code]}, {'Accept' => 'application/json'})
    # body_hash = JSON.parse(resp.body)
    # session[:token] = body_hash["access_token"]
    #
    # access_token_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # next_body_hash = JSON.parse(access_token_resp.body)
    # session[:username] = next_body_hash["login"]
    #
    #
    #
    # redirect_to root_path
  end
end
