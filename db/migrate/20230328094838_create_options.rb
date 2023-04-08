# frozen_string_literal: true
class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.string :name
      t.bigint :total_vote_count
      t.references :question, foreign_key: true
      t.timestamps
    end
  end
end
