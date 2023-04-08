# == Schema Information
#
# Table name: voter_participations
#
#  id             :bigint           not null, primary key
#  question_index :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  election_id    :bigint
#  voter_id       :bigint
#
# Indexes
#
#  index_voter_participations_on_election_id  (election_id) UNIQUE
#  index_voter_participations_on_voter_id     (voter_id)
#
# Foreign Keys
#
#  fk_rails_...  (election_id => elections.id)
#  fk_rails_...  (voter_id => voters.id)
#
require "test_helper"

class VoterParticipationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
