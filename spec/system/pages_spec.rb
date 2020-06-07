require 'rails_helper'

RSpec.feature 'Pages', type: :system do

    scenario "ログインしてユーザページに遷移する" do
        @user = create(:user)
        create(:recent_event)
        visit '/users/sign_in'
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        click_button 'Log in'
        expect(page).to have_content('RECENT EVENTS')
    end

end