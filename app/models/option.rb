class Option < ApplicationRecord
  belongs_to :question

  validates :name, presence: true

  def update_count
    self.total_vote_count += 1
    self.save
  end
end
