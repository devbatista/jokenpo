class ApplicationController < ActionController::API

  def authorize_request
    authorization = request.headers['Authorization']
    authorization = authorization.split(' ').last if authorization
    begin
      @decoded = JsonWebToken.decode(authorization)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end
end
