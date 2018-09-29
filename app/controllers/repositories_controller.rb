class RepositoriesController < ApplicationController

  def index
    @repositories = []
    if current_user.present?
      auth_result = JSON.parse(RestClient.get('https://api.github.com/user/repos', {:params => {:access_token => '075b67470ce2ff8f8ce26d4ae12e3ca57774e45a'} }))
      auth_result.each do |x|
        @repositories << {name: x['name'], full_name: x['full_name']}
      end
    else
      redirect_to root_path, :notice => "Unauthorize."
    end

  end

end
