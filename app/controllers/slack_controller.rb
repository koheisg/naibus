class SlackController < ActionController::API
  def endpoint
    res = SlackService.call(params)
    render json: res, status: 200
  end
end
