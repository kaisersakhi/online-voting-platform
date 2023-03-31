class Election < ApplicationRecord
  has_many :questions
  has_many :voter_participations

  # Election can be any of the three states
  # 1. draft -> only admins can see and do crud on it
  # 2. active -> immutable to admins
  # 3. archived ->

  def self.draft_elections
    all.where("status = ?", "draft")
  end

  def self.active_elections
    all.where("status = ?", "active")
  end

  def self.archived
    all.where("status = ?", "archived")
  end

  def launch
    status = "active"
    save
  end

  def end
    status = "archived"
    save
  end

  def to_s
    "#{name} | #{status}"
  end
end
