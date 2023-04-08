# frozen_string_literal: true
class FixVoterColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :voters, :password_plain, :password_digest
  end
end
