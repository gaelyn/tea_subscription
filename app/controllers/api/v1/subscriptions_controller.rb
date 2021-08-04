class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end

  def create
    sub = Subscription.new(subscription_params)
    if sub.save
      render json: SubscriptionSerializer.new(sub), status: 201
    else
      render json: { errors: 'Unable to create subscription' }, status: :bad_request
    end
  end

  def update
    sub = Subscription.find(params[:id])
    sub.update!(status: params[:status].to_i)
    render json: SubscriptionSerializer.new(sub), status: 200
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
  end
end
