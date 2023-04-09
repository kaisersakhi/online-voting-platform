# frozen_string_literal: true
class SessionsController < ApplicationController

  # GET /login
  def new
    # if user is already logged in
    if current_user
      decide_redirect
    end
  end

  # POST /login
  def create
    email = params[:email_id]
    password = params[:password]
    user_role = params[:role]

    user = if user_role == 'admin'
             User.find_admin_by_email(email)
           else
             User.find_by_voter_id(email) # email has voter_id when role is voter
           end

    session[:current_user_id] if user&.authenticate(password)
    decide_redirect(user_role)
  end

  # DELETE /logout
  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    decide_redirect
  end

  # Not an action, just a helper method
  def decide_redirect(role = nil)
    # user is visiting login page, when logged in
    user_role = if current_user&.is_admin?
                  'admin'
                elsif current_user&.is_voter?
                  'voter'
                end
    if user_role
      flash[:message] = 'Successfully logged in!'
      if user_role == 'admin'
        redirect_to admin_dashboard_path
      else
        redirect_to active_election_path
      end
    else
      # when user isn't logged in, or failed to login in based on supplied role

      if role == 'admin'
        flash[:error] = 'Email or Password is not correct.'
        redirect_to admin_login_path
      else
        flash[:error] = 'Voter ID or Password is not correct.'
        redirect_to login_path
      end
    end
  end
end
