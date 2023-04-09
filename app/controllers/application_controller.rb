# frozen_string_literal: true

class ApplicationController < ActionController::Base

  helper_method :current_user

  def ensure_voter_login
    return if current_user&.is_voter?

    redirect_to login_path

  end

  def ensure_admin_login
    return if current_user&.is_admin?

    redirect_to admin_login_path
  end

  def current_user
    user_id = session[:current_user_id]
    if @current_user
      @current_user
    elsif user_id
      @current_user = User.find(user_id)
    end
  end

end
