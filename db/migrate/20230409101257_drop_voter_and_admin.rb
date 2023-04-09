class DropVoterAndAdmin < ActiveRecord::Migration[7.0]
  def change
    drop_table :voters
    drop_table :admins
  end
end
