require "test_helper"

class Admin::ChatThreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chat_thread = chat_threads(:one)
  end

  test "should get index" do
    get admin_chat_threads_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_chat_thread_url
    assert_response :success
  end

  test "should create chat_thread" do
    assert_difference("ChatThread.count") do
      post admin_chat_threads_url, params: { chat_thread: { channel_code: @chat_thread.channel_code, message: @chat_thread.message, message_code: @chat_thread.message_code, role: @chat_thread.role, team_code: @chat_thread.team_code, ts_code: @chat_thread.ts_code } }
    end

    assert_redirected_to admin_chat_thread_url(ChatThread.last)
  end

  test "should show chat_thread" do
    get admin_chat_thread_url(@chat_thread)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_chat_thread_url(@chat_thread)
    assert_response :success
  end

  test "should update chat_thread" do
    patch admin_chat_thread_url(@chat_thread), params: { chat_thread: { channel_code: @chat_thread.channel_code, message: @chat_thread.message, message_code: @chat_thread.message_code, role: @chat_thread.role, team_code: @chat_thread.team_code, ts_code: @chat_thread.ts_code } }
    assert_redirected_to admin_chat_thread_url(@chat_thread)
  end

  test "should destroy chat_thread" do
    assert_difference("ChatThread.count", -1) do
      delete admin_chat_thread_url(@chat_thread)
    end

    assert_redirected_to admin_chat_threads_url
  end
end
