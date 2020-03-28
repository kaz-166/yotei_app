class UsersController < ApplicationController
    before_action :sign_in_required, only: [:search]
    def index
    end
  
    def show
    end
  
    def follow
        User.follow(current_user.id, params[:id])
        redirect_to root_path
    end

    def search
        #検索結果のレコードを返す(検索結果に自分自身が含まれていた場合はそれを除く)
        @user = User.where(username: params[:search]).where.not(id: current_user.id)
    end

    private
        def user_params
            params.require(:user).permit(:id, :username, :email)
        end


end
