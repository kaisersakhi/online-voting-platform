class VotersController < ApplicationController
  def show
    election = Election.find(params[:e_id])

  end
end
