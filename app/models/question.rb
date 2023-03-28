class Question < ApplicationRecord
  belongs_to :election
  has_many :options, dependent: :destroy
end
