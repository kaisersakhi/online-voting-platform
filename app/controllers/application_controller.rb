class ApplicationController < ActionController::Base

  helper_method :current_user_info

  def ensure_voter_login
    unless  current_user_info && current_user_role == 'voter'
      redirect_to '/login'
    end
  end

  def ensure_admin_login
    unless current_user_info && current_user_role == 'admin'
      redirect_to '/admin/login'
    end
  end



  def current_user_info

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
