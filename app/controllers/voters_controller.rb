class VotersController < ApplicationController

  def show
    # election = Election.find(params[:e_id])

  end

  def index


    render 'index', locals: {
      voters: Voter.all
    }
  end
  def new

  end

  def create
    voter_id = params[:voter_id]
    voter_password = params[:voter_password]

    new_voter = Voter.new(
      voter_id: voter_id,
      password_plain: voter_password
      )

    new_voter.save

    redirect_to '/admin/dashboard'
  end
end
