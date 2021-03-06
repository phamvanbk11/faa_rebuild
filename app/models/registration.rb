class Registration < ApplicationRecord
  acts_as_paranoid
  belongs_to :course_schedule
  has_one :course, through: :course_schedule

  enum status: {pending: 0, contacted: 1, rejected: 2}, _prefix: true
  enum list_reason: {google: 0, viblo: 1, facebook: 2, friend: 3, other: 4}, _prefix: true

  serialize :reason, Array

  VALID_EMAIL_REGEX = /\A([A-Za-z0-9_.]+)@((?:[-a-z0-9]+\.)+[a-z]{2,4})\Z/
  VALID_PHONE_NUMBER_REGEX = /\A\+?\d{1,3}?[- .]?\(?(?:\d{2,3})\)?[- .]?\d\d\d[- .]?\d\d\d\d/
  validates :name, presence: true,
    length: {maximum: Settings.registrations.max_name_length}
  validates :email, presence: true,
    length: {maximum: Settings.registrations.max_email_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone, presence: true,
    length: {maximum: Settings.registrations.max_phone_length},
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, presence: true, length:
    {maximum: Settings.registrations.max_address_length}
  validates :reason, presence: true

  def course_name
    self.course_schedule.course_name
  end
end
