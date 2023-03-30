class SessionsController < ApplicationController

  def new
    if current_user_info
      decide_redirect
    else
      render 'new'
    end
  end

  def create
    email = params[:email_id]
    password = params[:password]
    user_role = params[:role]

    user = if user_role == 'admin'
             Admin.find_by(email: email)
           else
             Voter.find_by(voter_id: email) # email has voter_id when role is voter
           end

    if user&.authenticate(password)
      session[:current_user] = {
        user_id: user.id,
        role: user_role
      }
    end

    decide_redirect(user_role)
  end

  def destroy

  end

  def decide_redirect(role = nil)
    # user is visiting login page, when logged in
    user_role = current_user_info[:role]
    if current_user_info
      if user_role == 'admin'
        redirect_to '/admin/dashboard'
      else
        redirect_to '/elections/active'
      end
    else
      # when user isn't logged in, or failed to login in based on supplied role
      if role == 'admin'
        redirect_to '/admin/login'
      else
        redirect_to '/login'
      end
    end
  end
end
