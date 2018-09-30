class RepositoriesController < ApplicationController

  def index
    @repositories = []
    if current_user.present?
      auth_result = JSON.parse(RestClient.get('https://api.github.com/user/repos', {:params => {:access_token => current_user.oauth_token } }))
      auth_result.each do |x|
        @repositories << {name: x['name'], full_name: x['full_name']}
      end
    else
      redirect_to root_path, :notice => "Unauthorized."
    end

  end

  def show
    @repository = nil
    if current_user.present?
      url = "https://api.github.com/repos/#{params[:format]}"
      auth_result = JSON.parse(RestClient.get(url, {:params => {:access_token => current_user.oauth_token } }))

      @repository = {name: auth_result['name'], description: auth_result['description']}
    else
      redirect_to root_path, :notice => "Unauthorized."
    end
  end

end
