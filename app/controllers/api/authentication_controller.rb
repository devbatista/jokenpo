class Api::AuthenticationController < Api::ApiController
  before_action :authorize_request, except: :login

  # POST /login
  def login
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token , exp: time.strftime("%d-%m-%Y %H:%M"), username: @username}, status: :ok 
    else
      render json: { error: 'unauthorized'}, status: :unauthorized
    end
  end

  private
    def login_params
      params.permit(:username, :password)
    end
end
