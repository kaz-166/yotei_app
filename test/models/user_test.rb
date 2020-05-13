require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(username: "Example", email: "user@example.com", password: "aaa", password_confirmation: "aaa")
  end

  #正しいデータ
  test "should be valid" do
    user = User.new(username: "Example", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    assert user.valid?
  end
  #パスワードが短い場合はNG
  test "should be invalid with too short password" do
    user = User.new(username: "Example", email: "user@example.com", password: "foo", password_confirmation: "foo")
    assert user.invalid?
  end

  #名前がない場合はNG
  test "should be invalid with no name" do
    user = User.new(username: "", email: "user@example.com", password: "foo", password_confirmation: "foo")
    assert user.invalid?
  end

end
