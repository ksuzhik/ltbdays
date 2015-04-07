class Payment < ActiveRecord::Base
  belongs_to :user
  validates :payment_sum, numericality: true, presence: true
  validates :month, numericality: :only_integer, presence: true
end
