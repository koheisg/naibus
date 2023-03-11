require "application_system_test_case"

class ChatThreadsTest < ApplicationSystemTestCase
  setup do
    @chat_thread = chat_threads(:one)
  end

  test "visiting the index" do
    visit chat_threads_url
    assert_selector "h1", text: "Chat threads"
  end

  test "should create chat thread" do
    visit chat_threads_url
    click_on "New chat thread"

    fill_in "Channel code", with: @chat_thread.channel_code
    fill_in "Message", with: @chat_thread.message
    fill_in "Message code", with: @chat_thread.message_code
    fill_in "Role", with: @chat_thread.role
    fill_in "Team code", with: @chat_thread.team_code
    fill_in "Ts code", with: @chat_thread.ts_code
    click_on "Create Chat thread"

    assert_text "Chat thread was successfully created"
    click_on "Back"
  end

  test "should update Chat thread" do
    visit chat_thread_url(@chat_thread)
    click_on "Edit this chat thread", match: :first

    fill_in "Channel code", with: @chat_thread.channel_code
    fill_in "Message", with: @chat_thread.message
    fill_in "Message code", with: @chat_thread.message_code
    fill_in "Role", with: @chat_thread.role
    fill_in "Team code", with: @chat_thread.team_code
    fill_in "Ts code", with: @chat_thread.ts_code
    click_on "Update Chat thread"

    assert_text "Chat thread was successfully updated"
    click_on "Back"
  end

  test "should destroy Chat thread" do
    visit chat_thread_url(@chat_thread)
    click_on "Destroy this chat thread", match: :first

    assert_text "Chat thread was successfully destroyed"
  end
end
