class Election < ApplicationRecord
  has_many :questions
  has_many :voter_participations
  def to_s
    "#{name} | #{status}"
  end
end
