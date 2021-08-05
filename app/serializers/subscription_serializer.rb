class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :customer_id, :tea_id, :title, :price, :status, :frequency
end
