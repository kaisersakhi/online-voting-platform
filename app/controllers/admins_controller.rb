class AdminsController < ApplicationController
  def dashboard
    p session
    render 'dashboard'
  end
end
