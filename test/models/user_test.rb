# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  is_admin        :boolean
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  voter_id        :string
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
