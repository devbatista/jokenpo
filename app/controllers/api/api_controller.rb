module Api
  class ApiController < ApplicationController

    def authorized
      render json: { error: 'This user is not authorized to perform the action' } unless admin?
    end

    def admin?
      @current_user.admin
    end
  end
end