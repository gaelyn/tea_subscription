class Api::V1::Customers::SubscriptionsController < ApplicationController
  before_action :set_customer
  before_action :set_tea, only: %i[create]

  def index
    if @customer.subscriptions.count == 0
      render json: { errors: "No subscriptions found" }, status: :ok
    else
      render json: SubscriptionSerializer.new(@customer.subscriptions)
    end
  end

  def create
    sub = @customer.subscriptions.new(subscription_params)
    if @customer.teas.find_by(id: params[:tea_id])
      render json: { errors: "You're already subscribed to this tea" }, status: :bad_request
    elsif sub.save
      render json: SubscriptionSerializer.new(sub), status: :created
    else
      render json: { errors: sub.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def update
    sub = @customer.subscriptions.find(params[:id])
    sub.update!(subscription_params)
    render json: SubscriptionSerializer.new(sub), status: :ok
    rescue StandardError => e
      render json: { errors: e }, status: :bad_request
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
  end

  def set_customer
    @customer = Customer.find_by(id: params[:customer_id])
    if @customer.nil?
      render json: { errors: "Cannot find customer" }, status: :not_found
    end
  end

  def set_tea
    @tea = Tea.find_by(id: params[:tea_id])
    if @tea.nil?
      render json: { errors: "Cannot find tea" }, status: :not_found
    end
  end
end
