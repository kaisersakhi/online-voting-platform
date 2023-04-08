# == Schema Information
#
# Table name: questions
#
#  id                   :bigint           not null, primary key
#  question_description :string
#  question_name        :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  election_id          :bigint
#
# Indexes
#
#  index_questions_on_election_id  (election_id)
#
# Foreign Keys
#
#  fk_rails_...  (election_id => elections.id)
#
class Question < ApplicationRecord
  belongs_to :election
  has_many :options, dependent: :destroy


  validates :question_name, presence: true
  validates :question_description, presence: true
end
