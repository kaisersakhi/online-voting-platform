class QuestionsController < ApplicationController
  before_action :ensure_voter_login

  def show # method to render HTML form for voting in an election
    election = Election.find(params[:e_id])
    questions = election.questions
    user_id = get_current_user&.id
    if session[:question_index].nil?
      session[:question_index] = 0
    end

    if session[:question_index] == questions.length
      # redirect voter to dashboard
      # and add entry into voter_participation's table
      flash[:message] = "You've Successfully voted in #{election.name}"
      redirect_to root_path
      session[:question_index] = 0
    else
      render 'show', locals: {
        election: election,
        question: questions[session[:question_index]]
      }

      session[:question_index] = session[:question_index] + 1
    end

    # if there is at least one question in an election
    # after sending out first question, question_index will be 1
    # on that event, i am marking user as participated in that election.
    # voter will be considered as voted in an election, when he/she
    # votes for first question

    if session[:question_index] == 1
      election.voter_participations.create!(
        election_id: election.id,
        voter_id: user_id
      )
    end
  end

  def update_option # method to update vote count
    option = Option.find(params[:opt_id])
    option.update_count
    redirect_to vote_path(e_id: params[:e_id])
  end
end
