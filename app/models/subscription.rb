class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates_presence_of :tea_id, :customer_id, :title, :price, :status, :frequency

  enum status: [:active, :inactive]
  enum frequency: [:monthly, :bimonthly, :trimonthly]

end
