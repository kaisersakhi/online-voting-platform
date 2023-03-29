class QuestionsController < ApplicationController

  def add_question
    question_name = params[:question_name]
    question_description = params[:question_description]
    options = params[:options].to_s.split(",")

    election = Election.find(params[:id])

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

    redirect_to "/elections/drafts/edit/#{election.id}"
  end

  # GET election/:e_id/question/:q_id/edit
  def edit # return an HTML form to edit a question
    election = Election.find(params[:e_id])
    question = election.questions.find(params[:q_id])
    render 'edit', locals: {
      question: question,
      election_id: election.id
    }
  end

  # PATCH election/:id/question/:id
  def update # update a specific question
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

  def destroy
    election = Election.find(params[:e_id])
    question = election.questions.find(params[:q_id])
    question.destroy!
    redirect_to "/elections/drafts/edit/#{election.id}"
  end

end
