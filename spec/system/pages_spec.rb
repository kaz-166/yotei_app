require 'rails_helper'

RSpec.feature 'Pages', type: :system do

    def log_in
        @user = create(:user)
        visit '/users/sign_in'
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        click_button 'Log in'
    end

    scenario "ログインしてユーザページに遷移する" do
        log_in
        expect(page).to have_content('RECENT EVENTS')
    end

    scenario "新規予定を作成する" do
        log_in
        visit '/events/new'
        fill_in 'event_name', with: "新規予定"
        fill_in 'event_abstract', with: "概要説明"
        fill_in 'event_location', with: "場所"
        select "2021", from: 'event_start_time_1i'
        select "March", from:  'event_start_time_2i'
        select "7", from:  'event_start_time_3i'
        select "12", from: 'event_start_time_4i'
        select "20", from: 'event_start_time_5i'
        select "2021", from: 'event_end_time_1i'
        select "March", from:  'event_end_time_2i'
        select "7", from:  'event_end_time_3i'
        select "12", from: 'event_end_time_4i'
        select "40", from: 'event_end_time_5i'
        click_button 'commit'
        expect(page).to have_content('新規予定')
        
    end

    scenario "新しい友達を表示する" do
        log_in
        @friend = create(:friend)
        fill_in 'search', with: "friend"
        click_button 'Search'
        expect(page).to have_content('friend')
    end
    
end