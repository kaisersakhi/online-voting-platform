class CreateVoterParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table(:voter_participations, primary_key: [:voter_id, :election_id]) do |t|
      t.belongs_to :election
      t.belongs_to :voter
      t.timestamps
    end
  end
end
