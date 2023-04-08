# frozen_string_literal: true
class RenameElectionStatusColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :elections, :status
    add_column :elections, :status, :integer, default: 1
  end
end
