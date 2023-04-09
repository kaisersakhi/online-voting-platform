class QuestionsController < ApplicationController
  before_action :ensure_voter_login

  # method to render HTML form for voting in an election
  def show

    election = Election.find(params[:e_id])
    questions = election.questions
    user_id = current_user&.id

    current_index = VoterParticipation.get_question_index(election.id, user_id)
    # if it is the last question, then end the process of showing questions
    # i am checking for ==, because im incrementing after the response is sent
    # it is same like incrementing before
    if current_index == questions.length
      # redirect voter to dashboard
      # and add entry into voter_participation's table
      flash[:message] = "You've Successfully voted in #{election.name}"
      redirect_to root_path
    else
      # else keep showing questions
      render 'show', locals: {
        election: election,
        question: questions[current_index]
      }
    end

    # if there is no entry, then create new one
    unless VoterParticipation.is_present(election.id, user_id)
      election.voter_participations.create!(
        election_id: election.id,
        voter_id: user_id,
        question_index: 1
      )
      return # return because, current_index=0 when this executes
      # so im setting the index in db to 1, saving a read and write to db :)
    end
    VoterParticipation.inc_index_value(election.id, user_id)
  end

  # method to update vote count
  def update_option
    option = Option.find(params[:opt_id])
    option.update_count
    redirect_to vote_path(e_id: params[:e_id])
  end
end
