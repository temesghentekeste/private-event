class UsersController < ApplicationController
  before_action :authenticate_user!

  def index 
    @users = User.all.reject { |user| user == Event.find(params[:attended_event_id]).creator }
  end 
  
  def show 
    @user = User.find(params[:id])
  end
end