require 'rails_helper'

RSpec.describe "UsersEdits", type: :request do
  describe "showのテスト" do
    before do
        @user = FactoryBot.create(:user)
        @event = FactoryBot.create(:event)
    end
    it "非ログイン時はログインページにリダイレクト" do
        post user_session_path, params: {email: "sample@example.com", password: "foobar" }
        expect(response).to be_successful
        expect(@user.username).to eq "test"
        expect(@user.password).to eq "foobar"

        get pages_show_path
        expect(response).to be_successful
    end

    it "イベント情報をみる" do
        get events_show_path(1)
        expect(response).to be_successful
    end
end


end
