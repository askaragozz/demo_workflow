class Technician < ApplicationRecord

  has_many :work_orders, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, length: { minimum: 10, maximum: 15 }

  validate :must_have_at_least_one_specialization

  private

  def must_have_at_least_one_specialization
    if specializations.blank? || specializations.empty?
      errors.add(:specializations, "Must have at least one specialization")
    end
  end

end