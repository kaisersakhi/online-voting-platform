class SessionsController < ApplicationController

  def new
    if get_current_user
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
        'user_id' => user.id,
        'role' => user_role
      }
      # p session
    end

    decide_redirect(user_role)
  end

  def destroy
    current_role = get_current_user_role
    session[:current_user] = nil
    @current_user_info = nil
    decide_redirect(current_role)
  end

  def decide_redirect(role = nil)
    # user is visiting login page, when logged in
    user_role = get_current_user_role


    if user_role
      flash[:message] = "Successfully logged in!"
      if user_role == 'admin'
        redirect_to admin_dashboard_path
      else
        redirect_to active_election_path
      end
    else
      # when user isn't logged in, or failed to login in based on supplied role

      if role == 'admin'
        flash[:error] = "Email or Password is not correct."
        redirect_to admin_login_path
      else
        flash[:error] = "Voter ID or Password is not correct."
        redirect_to login_path
      end
    end
  end
end
