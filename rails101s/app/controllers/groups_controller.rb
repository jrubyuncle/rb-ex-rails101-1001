class GroupsController < ApplicationController
  def index
    flash[:notice] = "(notice) good morning"
    flash[:alert] = "this is alert"
    flash[:warning] = "this is warning"
  end
end
