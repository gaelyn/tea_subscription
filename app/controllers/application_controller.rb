class ApplicationController < ActionController::API
  rescue_from ArgumentError, with: :invalid_params
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  def no_subs
    render json: { errors: "No subscriptions found" }, status: :ok
  end

  private

  def invalid_params(e)
    render json: { errors: e }, status: :bad_request
  end

  def invalid_record(e)
    render json: { errors: e.record.errors.full_messages.to_sentence }, status: :bad_request
  end
end
