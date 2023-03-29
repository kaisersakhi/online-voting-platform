class Election < ApplicationRecord
  has_many :questions
  has_many :voter_participations

  def self.draft_elections
    all.where("status = ?", "draft")
  end

  def to_s
    "#{name} | #{status}"
  end
end
