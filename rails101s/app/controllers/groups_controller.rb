class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @groups = Group.all
    #flash[:notice] = "(notice) good morning"
    #flash[:alert] = "this is alert"
    #flash[:warning] = "this is warning"
  end

  def show
    @group = Group.find params[:id]
    @posts = @group.posts
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      @group.members << current_user
      redirect_to groups_path, notice: "create group ok"
    else
      render :new
    end
  end

  def edit
    @group = current_user.groups.find params[:id]
  end

  def update
    @group = current_user.groups.find params[:id]

    if @group.update group_params
      redirect_to groups_path, notice: "modify ok"
    else
      render :edit
    end
  end

  def destroy
    @group = current_user.groups.find params[:id]
    @group.destroy
    redirect_to groups_path, notice: "destroy group ok"
  end

  def join
    @group = Group.find params[:id]

    if current_user.is_member_of?(@group)
      flash[:warning] = "already member"
    else
      #@group.members << current_user
      #current_user.participated_groups << @group
      current_user.join!(@group)

      flash[:notice] = "join ok"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find params[:id]

    if current_user.is_member_of?(@group)
      #@group.members.delete(current_user)
      #current_user.participated_groups.delete(@group)
      current_user.quit!(@group)

      flash[:alert] = "quit ok"
    else
      flash[:warning] = "not member"
    end

    redirect_to group_path(params[:id])
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end
end
