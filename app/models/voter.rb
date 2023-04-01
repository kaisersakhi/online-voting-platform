class Voter < ApplicationRecord
  has_many :voter_participations
  has_secure_password

  def update_record(first_name, last_name, password)
    self.first_name = first_name
    self.last_name = last_name
    self.password = password unless password.blank?

    self.save
  end
end
