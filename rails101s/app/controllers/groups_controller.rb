class GroupsController < ApplicationController
  def index
    flash[:notice] = "(notice) good morning"
    flash[:alert] = "this is alert"
    flash[:warning] = "this is warning"
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
