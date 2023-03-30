class Voter < ApplicationRecord
  has_many :voter_participations
  has_secure_password
end
