class Question < ApplicationRecord
  belongs_to :election
  has_many :options, dependent: :destroy

  validates :question_name, presence: true
  validates :question_description, presence: true
end
