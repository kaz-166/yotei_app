require 'rails_helper'

RSpec.describe "UsersEdits", type: :request do
  describe "GET /users_edits" do
    it "works! (now write some real specs)" do
      user = User.new(username: "Example", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
      get edit_user_registration_path
      expect(response).to have_http_status(200)
    end

    it "change user name" do
      user = User.new(username: "Example", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
      expect(user.valid?)
    end
  end


end
