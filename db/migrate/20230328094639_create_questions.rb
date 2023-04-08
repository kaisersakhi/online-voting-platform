# frozen_string_literal: true
class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :question_name
      t.string :question_description
      t.references :election, foreign_key: true

      t.timestamps
    end
  end
end
