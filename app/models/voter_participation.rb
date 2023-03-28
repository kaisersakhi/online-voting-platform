class VoterParticipation < ApplicationRecord
  belongs_to :voter
  belongs_to :election
end
