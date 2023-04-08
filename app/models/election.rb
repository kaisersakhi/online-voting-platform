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
class Election < ApplicationRecord
  has_many :questions
  has_many :voter_participations

  validates :name, presence: true

  enum status: { draft: 1, active: 2, archived: 3 }
  # Election can be any of the three states
  # 1. draft -> only admins can see and do crud on it
  # 2. active -> immutable to admins
  # 3. archived ->

  def launch
    self.status = :active
    self.save
  end

  def end
    self.status = :archived
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
    if new_question.save
      options.each do |option|
        new_question.options.create!(
          name: option.strip,
          total_vote_count: 0
        )
      end
    else
      flash[:error] = new_question.errors.full_messages.join(",")
    end
  end

  def self.get_unique_slug(slug)
    duplicates = Election.all.find_by(custom_url: slug)
    if duplicates.present?
      # slug is already present in the database : duplicate
      # Algorithm :
      #  num1 = random(1, 10)
      #  num2 = random(0, 100)
      #  suffix = num1.to_s + num2.to_s
      #  random_char = [a..z][rand(26)]
      #  slug + '-' + random_char + suffix
      #  return slug
      suffix = (rand(10) + 1).to_s + rand(100).to_s
      random_char = ('a'..'z').to_a[rand(26)]
      slug << "-#{random_char}#{suffix}"
    else
      slug
    end
  end
end
