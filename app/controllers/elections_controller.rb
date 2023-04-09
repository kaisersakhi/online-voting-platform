# frozen_string_literal: true
class ElectionsController < ApplicationController

  before_action :ensure_admin_login, except: [:active_elections, :archived, :get_by_custom_url]

  # display a list of elections
  #  GET /elections
  def index
    # this route isn't used anywhere, but is accessible
    render plain: Election.all.map(&:to_s).join("\n")
  end

  # return an HTML form for creating new election
  # GET /elections/new
  def new; end

  # create a new election
  # POST /elections
  def create
    election_name = params[:election_name]
    election_custom_url = params[:election_custom_url].to_s.parameterize

    election_custom_url = election_name.to_s.parameterize if election_custom_url.blank?

    if election_name.blank?
      flash[:error] = "Election must have a name."
      redirect_to new_election_path
    else
      new_election = Election.new(
        name: election_name,
        custom_url: Election.get_unique_slug(election_custom_url)
      )
      flash[:error] = new_election.errors.full_messages.join(',') unless new_election.save
      redirect_to admin_dashboard_path
    end
  end

  # GET /elections/drafts
  def show_draft_elections
    @elections = Election.draft
    render 'draft_elections'
  end

  # GET /elections/drafts/edit/:id
  def edit_draft
    election_id = params[:id]
    @election = Election.find(election_id)
    render 'edit_draft'
  end

  # PATCH /elections/:id/launch
  def launch
    election = Election.find(params[:id])
    # check if there is at least one question in specified election
    if election.questions.present?
      election.launch
      redirect_to admin_dashboard_path
    else
      flash[:error] = "There must be at least one question, for election to launch."
      redirect_to edit_draft_path(id: election.id)
    end
  end

  # PATCH /elections/:id/end
  def end
    election = Election.find(params[:id])
    election.end
    redirect_to admin_dashboard_path
  end

  # GET /elections/active
  def active_elections
    @elections = Election.active
    @is_admin = current_user&.is_admin?
    render 'active'
  end

  # GET /elections/archived
  def archived
    @elections = Election.archived
  end

  # GET /elections/e/:name
  def get_by_custom_url
    election = Election.find_by(custom_url: params[:name])

    if election
      @election = election
      @total_votes = election.voter_participations.size
      render 'show'
    else
      flash[:error] = "No elections found!"
      redirect_to root_path
    end
  end

  # display a specific election
  # GET /elections/:id
  def show
    @election = Election.find(params[:id])
    @total_votes = @election.voter_participations.size
    render 'show'
  end

  # PATCH /election/:id/question
  #  @param :question_name
  #  @param : question_description
  #  @param :options ; example "option1, option2, ...., option n"
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
    redirect_to edit_draft_path(id: election.id)
  end

  # update a specific question <br>
  # PATCH election/:id/question/:id
  def update_question
    election = Election.find(params[:e_id])
    question = Question.find(params[:q_id])
    question.question_name = params[:question_name]
    question.question_description = params[:question_description]
    question.save

    # for options to update correctly, admin must maintain the options order
    options = params[:options].to_s.split(",")
    question.options.destroy_all
    # admin has added new options
    options.each do |opt|
      question.options.create!(
        name: opt.strip,
        total_vote_count: 0
      )
    end
    redirect_to edit_draft_path(id: election.id)
  end

  # return an HTML form to edit a question
  # GET /election/:e_id/question/:q_id/edit
  def edit_question
    election = Election.find(params[:e_id])
    @question = election.questions.find(params[:q_id])
    @election_id = election.id
  end

  # DELETE /election/:e_id/question/:q_id
  def destroy_question
    Question.find(params[:q_id])
    question.destroy!
    redirect_to edit_draft_path(id: e_id)
  end

  # returns an HTML form for editing an elections
  # GET /elections/:id/edit
  def edit; end

  # update a specific election
  # PATCH /elections/:id
  def update; end

  # delete a specific elections
  # DELETE /elections/:id
  def destroy; end
end
