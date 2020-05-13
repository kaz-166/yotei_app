require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # t.text :content
  # t.integer :event_id
  # t.string :user_id
  # t.string :integer


  test "should be valid" do
    post = Post.new(content: "test", event_id: 4, user_id: "2")
    assert post.valid?
  end

  #内容のないポストはNG
  test "content should be present" do
    post = Post.new(content: "", event_id: 4, user_id: "2")
    assert post.invalid?
  end

  #ポストは255文字以内
  test "length of the content should be smaller than 256" do
    post = Post.new(content: "s"*256, event_id: 4, user_id: "2")
    assert post.invalid?
  end
end
