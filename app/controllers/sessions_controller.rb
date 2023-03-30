class SessionsController < ApplicationController


  def new

  end
  def create
    email = params[:email_id]
    password = params[:password]
    user_role = params[:role]

    user = if user_role == 'admin'
             Admin.find_by(email: email)
           else
             Voter.find_by(email: email)
           end
    if user&.authenticate(password)
      session[:current_user] = {
        user_id: user.id,
        role: user_role
      }
      if user_role == 'admin'
        redirect_to '/admin/dashboard'
      else
        redirect_to '/elections'
      end
    else
      if user_role == 'admin'
        redirect_to '/admin/login'
      else
        redirect_to '/login'
      end
    end
  end

  def destroy

  end
end
