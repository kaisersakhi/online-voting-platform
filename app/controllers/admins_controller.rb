class AdminsController < ApplicationController

  before_action :ensure_admin_login, except: [:create, :new, :login]
  def dashboard
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
      redirect_to admin_login_path
    else
      flash[:error] = new_admin.errors.full_messages.join(", ")
      redirect_to admin_login_path
    end
  end
end
