class RenameVoterId < ActiveRecord::Migration[7.0]
  def change
    rename_column :voter_participations, :voter_id , :user_id
  end
end
