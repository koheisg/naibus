class SlackController < ActionController::API
  def endpoint
    if params[:challenge]
      render json: { challenge: params[:challenge] }, status: 200
    else
      head :ok
    end
  end
end
