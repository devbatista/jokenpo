class Api::PlaysController < Api::ApiController
  
  def index
    options = ["Pedra", "Papel", "Tesoura"]

    return render json: {error: "Envie algum dado com a chave 'option'"} unless params[:option]
    return render json: {error: "Chave vazia, envie pedra, papel ou tesoura'"} if params[:option].empty?
    return render json: {error: "Opção inválida, escolha pedra, papel ou tesoura"} unless options.include?(params[:option].capitalize)
    
    @return = {you: params[:option].capitalize, pc: options.sample, result: ''}

    if @return[:you] == @return[:pc]
      @return[:result] = 'Empate' 
    else
      @return[:result] = ganhou_perdeu(@return[:you], @return[:pc])
    end

    render json: @return

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

end
