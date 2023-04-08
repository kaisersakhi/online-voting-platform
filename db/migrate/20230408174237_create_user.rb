class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :voter_id
      t.boolean :is_admin
      t.string :password_digest

      t.timestamps
    end
  end
end
