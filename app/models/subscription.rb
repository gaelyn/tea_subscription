class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  enum status: [:active, :inactive]
  enum frequency: [:monthly, :bimonthly, :trimonthly]
end
