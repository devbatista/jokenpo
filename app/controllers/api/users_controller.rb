class Api::UsersController < Api::ApiController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index show exclude change]
  before_action :authorized, only: %i[index display update destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /user
  def show
    render json: @current_user, status: :ok
  end

  # GET /user/{user_id}
  def display
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.cpf = CPF.new(user_params[:cpf]).formatted
    
    return password_confirmation? unless @user.password_confirmation

    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /users/{user_id}
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /user
  def change
    if @current_user.update(user_params)
      render json: @current_user, status: :ok
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /user/{user_id}
  def destroy
    return render json: { error: 'Para deletar seu usuário não é necessário passar parâmetros' }, status: :unprocessable_entity if @user == @current_user

    if @user.destroy
      render json: { message: 'Usuário deletado com sucesso' }, status: :ok
    else
      render json: { error: @user.errors.full_messages}, status: :bad_request
    end
  end

  # DELETE /user
  def exclude
    if @current_user.destroy
      render json: { message: 'Sua conta foi deletada com sucesso' }, status: :ok
    else
      render json: { error: @current_user.errors.full_messages}, status: :bad_request
    end
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