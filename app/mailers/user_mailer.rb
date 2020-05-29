class UserMailer < ApplicationMailer

    def remind(user)
        @user = User.first
        mail to: "#{@user.email}", subject: "Hello, #{@user.username}"
    end 

end

