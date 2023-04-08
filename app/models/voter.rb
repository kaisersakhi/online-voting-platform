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
class Voter < ApplicationRecord
  has_many :voter_participations
  has_secure_password

  validates :voter_id, presence: true
  validates :password_digest, presence: true

  def update_record(first_name, last_name, password)
    self.first_name = first_name
    self.last_name = last_name
    self.password = password unless password.blank?
    self.save
  end
end
