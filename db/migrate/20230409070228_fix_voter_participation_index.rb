class FixVoterParticipationIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :voter_participations, :voter_id
    remove_index :voter_participations, :election_id
    add_index :voter_participations, %i[election_id voter_id], unique: true
  end
end
