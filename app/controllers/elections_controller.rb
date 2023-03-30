class ElectionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :ensure_admin_login, except: [:active_elections, :archived, :get_by_custom_url]
  def index # display a list of elections
    render plain: Election.all.map { |election| election.to_s }.join("\n")
  end

  def new # return an HTML form for creating new election

  end

  def create # create a new election
    election_name = params[:election_name]
    election_custom_url = params[:election_custom_url]
    status = "draft"
    # puts election_custom_url, election_name

    new_election = Election.new(
      name: election_name,
      status: status,
      custom_url: election_custom_url.to_s.downcase.strip.gsub(' ', '-')
    )

    new_election.save

    redirect_to '/admin/dashboard'
  end



  def show_draft_elections
    render 'draft_elections', locals: {
      draft_elections: Election.draft_elections
    }
  end

  def edit_draft
    election_id = params[:id]
    render 'edit_draft', locals: {election: Election.find(election_id)}
  end

  def launch
    election = Election.find(params[:id])
    election.status = "active"
    election.save

    redirect_to '/admin/dashboard'
  end

  def end
    election = Election.find(params[:id])
    election.status = "archived"
    election.save

    redirect_to '/admin/dashboard'
  end

  def active_elections
    render 'active', locals: {
      elections: Election.active_elections,
      is_admin: current_user_role == 'admin'
    }
  end

  def archived
    render 'archived', locals: {elections: Election.archived}
  end

  def get_by_custom_url
    election = Election.find_by(custom_url: params[:name])
    render 'show', locals: {
      election: election,
      total_votes: election.voter_participations.size
    }
  end

  def show # display a specific election
    election = Election.find(params[:id])

    render 'show', locals: {
      election: election,
      total_votes: election.voter_participations.size
    }
  end

  def edit # returns an HTML form for editing an elections

  end

  def update # update a specific election

  end

  def destroy # delete a specific elections

  end
end
