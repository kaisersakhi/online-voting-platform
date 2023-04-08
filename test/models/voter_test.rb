# == Schema Information
#
# Table name: voters
#
#  id              :bigint           not null, primary key
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  voter_id        :string
#
require "test_helper"

class VoterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
