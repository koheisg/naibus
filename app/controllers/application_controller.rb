# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def current_workspace
    @current_workspace ||= Workspace.find_by(id: session[:workspace_id])
  end
  helper_method :current_workspace

  def require_connected_workspace
    redirect_to root_path unless current_workspace
  end
end
