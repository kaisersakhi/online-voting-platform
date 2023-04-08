class CreateVoterParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :voter_participations do |t|
      t.references :election, foreign_key: true
      t.references :voter, foreign_key: true
      t.integer :question_index

      t.timestamps
    end
  end
end
