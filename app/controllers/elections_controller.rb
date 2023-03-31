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
    election_custom_url = if election_custom_url == ""
                            election_name.to_s.downcase.strip.gsub(' ', '-')
                          else
                            election_custom_url.to_s.downcase.strip.gsub(' ', '-')
                          end
    status = "draft"
    # puts election_custom_url.class, election_name.class
    if election_name.to_s.length == ""
      flash[:error] = "Election must have a name."
      redirect_to '/elections/new'
    else
      new_election = Election.new(
        name: election_name,
        status: status,
        custom_url: election_custom_url
      )
      new_election.save
      redirect_to '/admin/dashboard'
    end
  end

  def show_draft_elections
    render 'draft_elections', locals: {
      draft_elections: Election.draft_elections
    }
  end

  def edit_draft
    election_id = params[:id]
    render 'edit_draft', locals: { election: Election.find(election_id) }
  end

  def launch
    election = Election.find(params[:id])
    if election.questions.size > 0
      election.launch
      redirect_to '/admin/dashboard'
    else
      flash[:error] = "There must be at least one question, for election launch."
      redirect_to "/elections/drafts/edit/#{election.id}"
    end
  end

  def end
    election = Election.find(params[:id])
    election.end
    redirect_to '/admin/dashboard'
  end

  def active_elections
    render 'active', locals: {
      elections: Election.active_elections,
      is_admin: current_user_role == 'admin'
    }
  end

  def archived
    render 'archived', locals: { elections: Election.archived }
  end

  def get_by_custom_url
    election = Election.find_by(custom_url: params[:name])

    if election
      render 'show', locals: {
        election: election,
        total_votes: election.voter_participations.size
      }
    else
      flash[:error] = "No elections found!"
      redirect_to '/'
    end
  end

  def show # display a specific election
    election = Election.find(params[:id])

    render 'show', locals: {
      election: election,
      total_votes: election.voter_participations.size
    }
  end


  def add_question
    question_name = params[:question_name]
    question_description = params[:question_description]
    options = params[:options].to_s.split(",")

    election = Election.find(params[:id])

    election.add_new_question(
      question_name,
      question_description,
      options
    )
    redirect_to "/elections/drafts/edit/#{election.id}"
  end


  # PATCH election/:id/question/:id
  def update_question # update a specific question
    # Todo: move this action to election_controller
    election = Election.find(params[:e_id])
    question = election.questions.find(params[:q_id])
    question.question_name = params[:question_name]
    question.question_description = params[:question_description]
    question.save
    # for options to update correctly, admin must maintain the options order

    options = params[:options].to_s.split(",")
    index = 0
    question.options.each do |option|
      option.name = options[index].strip
      option.save!
      index += 1
    end

    # admin has added new options
    while index < options.length
      question.options.create!(
        name: options[index].strip,
        total_vote_count: 0
      )
      index += 1
    end
    redirect_to "/elections/drafts/edit/#{election.id}"
  end


  def edit_question # return an HTML form to edit a question
    # Todo: move this action to election_controller
    election = Election.find(params[:e_id])
    question = election.questions.find(params[:q_id])
    render 'edit_question', locals: {
      question: question,
      election_id: election.id
    }
  end

  def destroy_question
    # Todo: move this action to election_controller
    election = Election.find(params[:e_id])
    question = election.questions.find(params[:q_id])
    question.destroy!
    redirect_to "/elections/drafts/edit/#{election.id}"
  end

  def edit # returns an HTML form for editing an elections

  end

  def update # update a specific election

  end

  def destroy # delete a specific elections

  end
end
