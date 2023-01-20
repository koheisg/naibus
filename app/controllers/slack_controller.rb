class SlackController < ActionController::API
  def endpoint
    res = SlackService.call(params)
    render json: res, status: 200
  end

  def auth_callback
    redirect_to root_path
  end
end
