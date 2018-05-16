# class RepositoriesController < ApplicationController
#   def index
#     resp = Faraday.get("https://api.github.com/user/repos") do |req|
#       req.headers['Authorization'] = "token #{session[:token]}"
#       req.headers['Accept'] = 'application/json'
#     end
#
#     @repos = JSON.parse(resp.body)
#   end
#
#   def create
#     resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
#     redirect_to root_path
#   end
# end



class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get 'https://api.github.com/user/repos', {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # do |req|
    #   req.params['access_token'] = session[:token]
    # end
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
