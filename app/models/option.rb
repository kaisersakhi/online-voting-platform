# == Schema Information
#
# Table name: options
#
#  id               :bigint           not null, primary key
#  name             :string
#  total_vote_count :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  question_id      :bigint
#
# Indexes
#
#  index_options_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
class Option < ApplicationRecord
  belongs_to :question

  validates :name, presence: true

  def update_count
    self.total_vote_count += 1
    self.save
  end
end
