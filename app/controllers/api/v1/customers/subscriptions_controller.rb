class Api::V1::Customers::SubscriptionsController < ApplicationController
  before_action :set_customer
  before_action :set_tea, only: %i[create]

  def index
    return no_subs if @customer.subscriptions.count == 0
    render json: SubscriptionSerializer.new(@customer.subscriptions)
  end

  def create
    sub = @customer.subscriptions.create!(subscription_params)
    render json: SubscriptionSerializer.new(sub), status: :created
  end

  def update
    sub = @customer.subscriptions.find(params[:id])
    sub.update(subscription_params)
    render json: SubscriptionSerializer.new(sub), status: :ok
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
