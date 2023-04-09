# == Schema Information
#
# Table name: voter_participations
#
#  id             :bigint           not null, primary key
#  question_index :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  election_id    :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_voter_participations_on_election_id_and_user_id  (election_id,user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (election_id => elections.id)
#  fk_rails_...  (user_id => users.id)
#
class VoterParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :election

  validates :user_id, presence: true
  validates :election_id, presence: true

  # increments `question_index` of specified `election_id` and `voter_id`
  def self.inc_index_value(election_id, voter_id)
    participation = all.find_by(election_id: election_id, user_id: voter_id)
    if !participation.nil?
      current_val = participation.question_index + 1
      # there seems to be an issue, ActiveRecord is not processing composite keys correctly
      # it generate invalid sql query
      # voter_participation = VoterParticipation.where(election_id: election_id, voter_id: voter_id).first
      participation.question_index = current_val
      participation.save
      # ActiveRecord::Base.connection.execute("UPDATE voter_participations SET question_index = #{current_val} WHERE voter_id = #{voter_id} AND election_id = #{election_id}")
    end
  end

  # gets question_index of an entry having specified election_id and voter_id
  def self.get_question_index(election_id, voter_id)
    participation = all.where(election_id: election_id, user_id: voter_id)
    index = participation.first&.question_index
    # if index is nil, return 0
    if index.nil?
      0
    else
      index
    end
  end

  # checks if a entry with specified election_id and voter_id is present
  def self.is_present(e_id, v_id)
    all.where(election_id: e_id, user_id: v_id).present?
  end
end
