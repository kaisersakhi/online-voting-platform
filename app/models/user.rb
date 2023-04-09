# frozen_string_literal: true
class User < ApplicationRecord

  has_secure_password

  def is_voter?
    !is_admin
  end

  def is_admin?
    is_admin
  end

  def self.voters
    all.where(is_admin: false)
  end

  def self.find_voter(user_id)
    voters.find(user_id)
  end

  def self.find_admin(user_id)
    all.where(is_admin: true, id: user_id)
  end

  def self.find_admin_by_email(email)
    admin = User.where(is_admin: true, email:)
    admin&.first
  end

  def self.find_by_voter_id(voter_id)
    voter =  all.where(is_admin: false, voter_id:)
    voter
  end

  # used to update voter details
  def update_record(first_name, last_name, password)
    self.first_name = first_name
    self.last_name = last_name
    self.password = password unless password.blank?
    save
  end
end
