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
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
