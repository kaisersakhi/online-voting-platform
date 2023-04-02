class AddColumnToVoterParticipation < ActiveRecord::Migration[7.0]
  def change
    add_column :voter_participations, :question_index, :integer
  end
end
