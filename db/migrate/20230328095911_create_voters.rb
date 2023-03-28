class CreateVoters < ActiveRecord::Migration[7.0]
  def change
    create_table :voters do |t|
      t.string :first_name
      t.string :last_name
      t.string :voter_id
      t.string :password_plain

      t.timestamps
    end
  end
end
