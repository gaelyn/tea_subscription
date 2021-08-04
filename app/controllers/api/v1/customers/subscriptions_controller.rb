class Api::V1::Customers::SubscriptionsController < ApplicationController
  before_action :set_customer

  def index
    render json: SubscriptionSerializer.new(@customer.subscriptions)
  end

  def create
    sub = @customer.subscriptions.new(subscription_params)
    if @customer.teas.find_by(id: params[:tea_id])
      render json: { errors: "You're already subscribed to this tea" }, status: :bad_request
    elsif sub.save
      render json: SubscriptionSerializer.new(sub), status: 201
    else
      render json: { errors: sub.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def update
    sub = @customer.subscriptions.find(params[:id])
    if (params[:status].to_i < 0) || (params[:status].to_i > 1)
      render json: { errors: "Invalid status" }, status: :bad_request
    else
      sub.update!(status: params[:status].to_i)
      render json: SubscriptionSerializer.new(sub), status: 200
    end
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
  end

  def set_customer
    @customer = Customer.find_by(id: params[:customer_id])
  end
end
