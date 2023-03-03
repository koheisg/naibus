class WorkspacesController < ApplicationController
  before_action :current_workspace

  def show
    redirect_to root_path unless current_workspace
  end

  helper_method :current_workspace
  def current_workspace
    @current_workspace ||= Workspace.find_by(id: session[:workspace_id])
  end
end
