class ApplicationController < ActionController::API
  rescue_from ArgumentError, with: :invalid_params

  private

  def invalid_params(e)
    render json: { errors: e }, status: :bad_request
  end
end
