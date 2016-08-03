# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#

class User < ApplicationRecord
  has_many :movings, dependent: :destroy
  has_many :social_profiles, dependent: :destroy

  # Include devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :omniauthable

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Validate email with a custom email validator.
  validates :email, presence: true, email: true

  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def reset_confirmation!
    self.update_column(:confirmed_at, nil)
  end

  # Makes current_user available via User.
  # Userd in ApplicationController.
  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  # References current_user via User.
  def self.current_user
    Thread.current[:current_user]
  end
end
