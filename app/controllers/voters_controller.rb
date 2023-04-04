class VotersController < ApplicationController

  before_action :ensure_admin_login

  def show
    # election = Election.find(params[:e_id])
  end

  def index
    # render 'index', locals: {
    #   voters: Voter.all
    # }
    @voters = Voter.all
  end

  def new
  end

  def create
    voter_id = params[:voter_id]
    voter_password = params[:voter_password]
    new_voter = Voter.new(
      voter_id: voter_id,
      password: voter_password
      )
    flash[:error] = new_voter.errors.full_messages.join(', ') unless new_voter.save
    redirect_to admin_dashboard_path
  end

  def edit
    render 'edit', locals: {
      voter: Voter.find(params[:id])
    }
  end

  def update
    first_name = params[:first_name]
    last_name = params[:last_name]
    password = params[:password]

    voter = Voter.find(params[:id])
    voter.update_record(first_name, last_name, password)

    redirect_to voters_path
  end

  def destroy
    voter = Voter.find(params[:id])
    voter.destroy!
    redirect_to voters_path
  end

end
