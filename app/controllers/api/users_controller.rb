class Api::UsersController < Api::ApiController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index show]
  before_action :authorized, only: %i[index display]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /user/{user_id}
  def show
    render json: @current_user, status: :ok
  end

  # GET /user
  def display
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    
    return password_confirmation? unless @user.password_confirmation

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

  # PUT /user
  def change
    unless @current_user.update(user_params)
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  def exclude
    @current_user.destroy
  end

  private
    def find_user
      @user = User.find(params[:user_id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
      params.permit(:avatar, :name, :username, :email, :cpf, :password, :password_confirmation, :admin)
    end

    def password_confirmation?
      render json: { errors: 'This field password_confirmation is required' }, status: :unprocessable_entity 
    end

end