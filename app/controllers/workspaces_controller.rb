# frozen_string_literal: true

class WorkspacesController < ApplicationController
  # before_action :require_connected_workspace

  def edit; end

  def show; end

  def update
    if current_workspace.update(workspace_params)
      redirect_to workspace_path
    else
      render :show
    end
  end

  private

  def workspace_params
    params.require(:workspace).permit(:open_ai_access_token, :system_message, :open_ai_model)
  end
end
