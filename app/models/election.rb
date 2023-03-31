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
    self.status = "active"
    self.save
  end

  def end
    self.status = "archived"
    self.save
  end

  def to_s
    "#{name} | #{status}"
  end

  def add_new_question(question_name, question_description, options)
    new_question = questions.new(
      question_name: question_name,
      question_description: question_description
    )
    new_question.save

    options.each do |option|
      new_question.options.create!(
        name: option.strip,
        total_vote_count: 0
      )
    end
  end
end
