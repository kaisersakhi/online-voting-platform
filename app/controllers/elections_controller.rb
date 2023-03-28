class ElectionsController < ApplicationController
  skip_before_action :verify_authenticity_token

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
  end

  def add_question
    question_name = params[:question_name]
    question_description = params[:question_description]
    options = params[:options].to_s.split(",")

    election = Election.find(params[:election_id])

    new_question = election.questions.new(
      question_name: question_name,
      question_description: question_description
    )
    new_question.save

    options.each do |option|
      new_question.options.create!(
        name: option.strip,
        total_vote_count: 0
      )

    end
  end

  def get_by_custom_url
    render plain: params[:id]
  end

  def show # display a specific election

  end

  def edit # returns an HTML form for editing an elections

  end

  def update # update a specific election

  end

  def destroy # delete a specific elections

  end
end
