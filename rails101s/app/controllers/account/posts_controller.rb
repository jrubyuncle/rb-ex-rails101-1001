class Account::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    #@posts = current_user.posts.order(updated_at: :desc)
    #@posts = current_user.posts.order("updated_at desc")
    @posts = current_user.posts.recent
  end
end
