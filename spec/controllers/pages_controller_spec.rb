require 'rails_helper'

RSpec.describe PagesController, type: :controller do
    
    
    describe "プライベートメソッドprefixのテスト" do
        context "引数が一桁" do
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

        context "引数が二桁" do
            it "should NOT be prefixed" do
                expect(PagesController.new.send(:prefix, 10)).to eq "10"
                expect(PagesController.new.send(:prefix, 11)).to eq "11"
                expect(PagesController.new.send(:prefix, 12)).to eq "12"
            end
        end
    end

end
