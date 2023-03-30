class AdminsController < ApplicationController

  before_action :ensure_admin_login, except: [:create, :new, :login]
  def dashboard
    @current_user = current_user
    @user_role = current_user_role
    render 'dashboard'
  end

  def new
    render 'new'
  end

  def login

  end

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email_id]
    password = params[:password]

    new_admin = Admin.new(
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password
    )

    if new_admin.save
      redirect_to '/admin/login'
    end
  end
end
