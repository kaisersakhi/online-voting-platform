class ElectionsController < ApplicationController

  def index # display a list of elections
    render plain: Election.all.map { |election| election.to_s}.join("\n")
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
