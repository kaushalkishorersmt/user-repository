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
    @repository_commits = []
    if current_user.present?
      url = "https://api.github.com/repos/#{params[:format]}"
      auth_result = JSON.parse(RestClient.get(url, {:params => {:access_token => current_user.oauth_token } }))

      @repository = {name: auth_result['name'], description: auth_result['description']}

      commits_url = "https://api.github.com/repos/#{params[:format]}/commits"
      repo_commits = JSON.parse(RestClient.get(commits_url , {:params => {:access_token => current_user.oauth_token } }))
      repo_commits.each do |x|
        @repository_commits << {commit_msg: x['commit']['message'], commit_date: x['commit']['author']['date']}
      end
    else
      redirect_to root_path, :notice => "Unauthorized."
    end

  end

  # "commits_url": "https://api.github.com/repos/benlcollins/github_api_viz/commits{/sha}",
  # "git_commits_url": "https://api.github.com/repos/benlcollins/github_api_viz/git/commits{/sha}",
  # GET /repos/:owner/:repo/commits
  # https://api.github.com/repos/kaushalkishorersmt/github_api_viz
end
