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

  end

  # PATCH election/:id/question/:id
  def update # update a specific question

  end

  def destroy
    election = Election.find(params[:e_id])
    question = election.questions.find(params[:q_id])
    question.destroy!
    redirect_to "/elections/drafts/edit/#{election.id}"
  end

end
