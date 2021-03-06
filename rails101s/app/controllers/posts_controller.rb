class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group
  before_action :member_required, only: [:new, :create]

  def new
    @post = current_user.posts.new
  end

  def create
    @post = @group.posts.new post_params
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group), notice: "New Post OK"
    else
      render :new
    end
  end

  def edit
    #@post = @group.posts.find params[:id]
    @post = current_user.posts.find params[:id]
    #@post = Post.find params[:id]
  end

  def update
    #@post = @group.posts.find params[:id]
    @post = current_user.posts.find params[:id]

    if @post.update post_params
      redirect_to group_path(@group), notice: "Update Post OK"
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find params[:id]
    @post.destroy
    redirect_to group_path(@group), alert: "Post Deleted OK"
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end

  def find_group
    @group = Group.find params[:group_id]
  end

  def member_required
    #current_user group.members

    #redirect_to group_path(@group) unless @group.include_member?(current_user)
    if not current_user.is_member_of?(@group)
      flash[:warning] = "only members can create post"
      redirect_to group_path(@group)
    end
  end
end
