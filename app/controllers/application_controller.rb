# frozen_string_literal: true

class ApplicationController < ActionController::Base

  helper_method :get_current_user_role, :get_current_user

  def ensure_voter_login
    unless  get_current_user && get_current_user_role == 'voter'
      redirect_to login_path
    end
  end

  def ensure_admin_login
    unless get_current_user && get_current_user_role == 'admin'
      redirect_to admin_login_path
    end
  end

  def get_current_user
    if @current_user_info
      @current_user_info[:user]
    else
      @current_user_info = current_user_info
      @current_user_info&.[](:user)
    end
  end

  def get_current_user_role
    if @current_user_info
      @current_user_info[:role]
    else
      @current_user_info = current_user_info
      @current_user_info&.[](:role)
    end
  end

  def current_user_info
    p session
    user_id = session[:current_user]&.[]('user_id')
    return unless user_id

    user = if current_user_role == 'admin'
             Admin.find(user_id)
           elsif current_user_role == 'voter'
             Voter.find(user_id)
           end
    {
      user: user,
      role: current_user_role
    }
  end

  def current_user_role
    session[:current_user]&.[]('role')
  end




end
