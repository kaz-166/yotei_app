require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

   # 名がなければ無効な状態であること
    it "is invalid without a username" do
      user = User.new(username: nil)
      user.valid?
      expect(user.errors[:username]).to_not include("can't be blank")
    end
   # メールアドレスがなければ無効な状態であること
   it "is invalid without an email address"
   # 重複したメールアドレスなら無効な状態であること
   it "is invalid with a duplicate email address"
   # ユーザーのフルネームを文字列として返すこと
   it "returns a user's full name as a string" 

end
