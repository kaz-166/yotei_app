class UserMailer < ApplicationMailer

    def remind(user)
        @user = User.first
        mail to: "#{@user.email}", subject: "Hello, #{@user.name}"
      end 

end

