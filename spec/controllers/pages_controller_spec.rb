require 'rails_helper'

RSpec.describe PagesController, type: :controller do
    # describe: テスト対象 -> showアクション
    describe "GET show" do
        # context: テスト条件 -> 非ログイン時
        context "When a user dosen't log in" do
            before do
                get :show
            end
            # it: アウトプット -> リダイレクト応答(302)
            it "should return http 302 status" do
                expect(response.status).to eq 302
            end
            # it: アウトプット -> サインインページにリダイレクト
            it "should resirect to signup page" do
                expect(response).to redirect_to new_user_session_path
            end
        end
        # context: テスト条件 -> ログイン状態の時
        context "When a user has logged in" do
            let(:user) { create(:user) }
            let(:events) { create_list(:recent_event, 5) }
            before do
                allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
                get :show
            end
            # it: アウトプット -> 成功(200)
            it "should return http 200 status" do
                expect(response.status).to eq 200
            end

            #it: アウトプット -> インスタンス変数eventが存在する
            it "should " do
                expect(assigns(:events).nil?).to eq false  
            end
        end   

    end
    
    # describe: テスト対象 -> privateメソッドprefix
    describe "prefix" do
        # context: テスト条件 -> 引数の桁数が1桁の場合
        context "When 0~9" do
            # it: アウトプット -> プレフィクスを付加する
            it "should be prefixed" do
                expect(PagesController.new.send(:prefix, 1)).to eq "01"
                expect(PagesController.new.send(:prefix, 2)).to eq "02"
                expect(PagesController.new.send(:prefix, 3)).to eq "03"
                expect(PagesController.new.send(:prefix, 4)).to eq "04"
                expect(PagesController.new.send(:prefix, 5)).to eq "05"
                expect(PagesController.new.send(:prefix, 6)).to eq "06"
                expect(PagesController.new.send(:prefix, 7)).to eq "07"
                expect(PagesController.new.send(:prefix, 8)).to eq "08"
                expect(PagesController.new.send(:prefix, 9)).to eq "09"
            end
        end
        # context: テスト条件 -> 引数の桁数が1桁の場合
        context "when 10~" do
            # it: アウトプット -> プレフィクスを付加しない
            it "should NOT be prefixed" do
                expect(PagesController.new.send(:prefix, 10)).to eq "10"
                expect(PagesController.new.send(:prefix, 11)).to eq "11"
                expect(PagesController.new.send(:prefix, 12)).to eq "12"
            end
        end
    end

end
