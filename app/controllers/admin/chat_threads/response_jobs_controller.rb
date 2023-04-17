# frozen_string_literal: true

module Admin
  module ChatThreads
    class ResponseJobsController < Admin::ApplicationController
      def create
        chat_thread = ChatThread.find(params[:chat_thread_id])
        workspace = Workspace.find_by!(workspace_code: chat_thread.team_code)

        SlackResponseJob.perform_later(workspace, chat_thread)

        redirect_to admin_chat_thread_url(chat_thread), notice: 'Response Job was successfully enqueued.'
      end
    end
  end
end
