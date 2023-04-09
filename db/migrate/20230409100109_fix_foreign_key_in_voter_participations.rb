class FixForeignKeyInVoterParticipations < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :voter_participations, column: :voter_id
    add_foreign_key :voter_participations, :users, column: :voter_id
  end
end
