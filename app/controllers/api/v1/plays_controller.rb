class Api::V1::PlaysController < Api::V1::ApiController
  
  def index
    options = ["Pedra", "Papel", "Tesoura"]
    
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
