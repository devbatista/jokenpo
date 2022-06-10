class Api::PlaysController < Api::ApiController

  before_action :authorize_request
  
  def index
    options = ["Pedra", "Papel", "Tesoura"]

    return render json: {error: "Envie algum dado com a chave 'option'"} unless params[:option]
    return render json: {error: "Chave vazia, envie pedra, papel ou tesoura'"} if params[:option].empty?
    return render json: {error: "Opção inválida, escolha pedra, papel ou tesoura"} unless options.include?(params[:option].capitalize)
    
    data = {user: current_user.name, you: params[:option].capitalize, pc: options.sample, result: ''}

    if data[:you] == data[:pc]
      data[:result] = 'Empate' 
    else
      data[:result] = ganhou_perdeu(data[:you], data[:pc])
    end

    render json: data

  end

  private
    def ganhou_perdeu(you, pc)
      case you
      when 'Pedra'
        retorno = pc == 'Tesoura' ? 'Ganhou' : 'Perdeu'
      when 'Papel'
        retorno = pc == 'Pedra' ? 'Ganhou' : 'Perdeu'
      when 'Tesoura'
        retorno = pc == 'Papel' ? 'Ganhou' : 'Perdeu'
      end

      retorno
    end

    def current_user
      authorization = request.headers['Authorization']
      authorization = authorization.split(' ').last if authorization
      
      decoded = JsonWebToken.decode(authorization)
      current_user = User.find(@decoded[:user_id])
    end

end
