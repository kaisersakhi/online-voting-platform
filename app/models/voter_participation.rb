# require 'composite_primary_keys'
class VoterParticipation < ApplicationRecord
  belongs_to :voter
  belongs_to :election

  validates :voter_id, presence: true
  validates :election_id, presence: true

  def self.inc_index_value(election_id, voter_id)
    participation = all.find_by(election_id: election_id, voter_id: voter_id)
    unless participation.nil?
      current_val = get_question_index(election_id, voter_id) + 1
      # there seems to be an issue, ActiveRecord is not processing composite keys correctly
      # it generate invalid sql query
      ActiveRecord::Base.connection.execute("UPDATE voter_participations SET question_index = #{current_val} WHERE voter_id = #{voter_id} AND election_id = #{election_id}")
    end
  end

  def self.get_question_index(election_id, voter_id)
    participation = all.where("election_id = ? and voter_id = ?", election_id, voter_id)
    participation.first&.question_index
  rescue
    nil
  end

  def self.is_present(e_id, v_id)
    all.where("election_id = ? and voter_id = ?", e_id, v_id).size > 0
  end
end
