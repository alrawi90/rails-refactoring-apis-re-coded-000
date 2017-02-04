require "openssl" 

class RepositoriesController < ApplicationController
	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
	before_action :set_github_service_obj
  def index
    # response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # @repos_array = JSON.parse(response.body)

    @repos_array=@gs.get_repos
   # raise @repos_array.inspect
  end

  def create
    #response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    @gs.create_repo(params[:name])
    redirect_to '/'
  end
  private
    def set_github_service_obj
    	@gs=GithubService.new({'access_token' => session[:token]})
    end
end
