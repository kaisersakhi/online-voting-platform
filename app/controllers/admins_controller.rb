# frozen_string_literal: true
class AdminsController < ApplicationController

  before_action :ensure_admin_login, except: [:create, :new, :login]

  # GET /admin/dashboard
  def dashboard; end


  # GET /admin/register
  def new; end

  # GET /admin/login
  def login; end

  # POST /admin/register
  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email_id]
    password = params[:password]

    new_admin = User.new(
      first_name:,
      last_name:,
      email:,
      is_admin: true,
      password:
    )

    if new_admin.save
      session[:current_user_id] = new_admin.id
      redirect_to admin_dashboard_path
    else
      flash[:error] = new_admin.errors.full_messages.join(", ")
      redirect_to admin_login_path
    end
  end
end
