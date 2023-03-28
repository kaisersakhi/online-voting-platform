class Election < ApplicationRecord
  has_many :questions

  def to_s
    "#{name} | #{status}"
  end
end
