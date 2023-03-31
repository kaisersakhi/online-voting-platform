class Option < ApplicationRecord
  belongs_to :question

  def update_count
    self.total_vote_count += 1
    self.save
  end
end
