class Api::UsersController < Api::ApiController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]
  before_action :authorized, on: :index

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /uses/{user_id}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    
    render json: { errors: 'password_confirmation is required' }, status: :unprocessable_entity unless @user.password_confirmation

    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private
    def find_user
      @user = User.find_by_username!(params[:username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
      params.permit(:avatar, :name, :username, :email, :cpf, :password, :password_confirmation, :admin)
    end

end