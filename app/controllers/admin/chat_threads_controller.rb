class Admin::ChatThreadsController < ApplicationController
  before_action :set_chat_thread, only: %i[ show edit update destroy ]

  # GET /admin/chat_threads or /admin/chat_threads.json
  def index
    @chat_threads = ChatThread.all
  end

  # GET /admin/chat_threads/1 or /admin/chat_threads/1.json
  def show
  end

  # GET /admin/chat_threads/new
  def new
    @chat_thread = ChatThread.new
  end

  # GET /admin/chat_threads/1/edit
  def edit
  end

  # POST /admin/chat_threads or /admin/chat_threads.json
  def create
    @chat_thread = ChatThread.new(chat_thread_params)

    respond_to do |format|
      if @chat_thread.save
        format.html { redirect_to admin_chat_thread_url(@chat_thread), notice: "Chat thread was successfully created." }
        format.json { render :show, status: :created, location: @chat_thread }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chat_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/chat_threads/1 or /admin/chat_threads/1.json
  def update
    respond_to do |format|
      if @chat_thread.update(chat_thread_params)
        format.html { redirect_to admin_chat_thread_url(@chat_thread), notice: "Chat thread was successfully updated." }
        format.json { render :show, status: :ok, location: @chat_thread }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/chat_threads/1 or /admin/chat_threads/1.json
  def destroy
    @chat_thread.destroy

    respond_to do |format|
      format.html { redirect_to admin_chat_threads_url, notice: "Chat thread was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_thread
      @chat_thread = ChatThread.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_thread_params
      params.require(:chat_thread).permit(:message_code, :ts_code, :message, :role, :team_code, :channel_code)
    end
end
