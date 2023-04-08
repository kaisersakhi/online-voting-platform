# == Schema Information
#
# Table name: admins
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Admin < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :password_digest, presence: true
end
