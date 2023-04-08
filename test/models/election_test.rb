# == Schema Information
#
# Table name: elections
#
#  id         :bigint           not null, primary key
#  custom_url :string
#  name       :string
#  status     :integer          default("draft")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ElectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
