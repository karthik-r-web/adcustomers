module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user
  end

  private

  def authenticate_user
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    decoded = JsonWebToken.decode(token)
    return render json: { error: "Unauthorized" }, status: :unauthorized unless decoded

    @current_user = User.find(decoded[:user_id])
  rescue
    render json: { error: "Invalid Token" }, status: :unauthorized
  end
end
