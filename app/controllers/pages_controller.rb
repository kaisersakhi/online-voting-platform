class PagesController < ApplicationController
  def main
    @current_user = current_user
    @user_role = current_user_role
    render 'main'
  end


end
