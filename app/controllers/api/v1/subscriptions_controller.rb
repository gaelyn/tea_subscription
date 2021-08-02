class Api::V1::SubscriptionsController < ApplicationController
  def create
    sub = Subscription.new(subscription_params)
    if sub.save
      # render json: SubscriptionSerializer.new(sub), status: 201
      render json: sub, status: 201
    else
      render json: { errors: 'Unable to create subscription' }, status: :bad_request
    end
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
  end
end
