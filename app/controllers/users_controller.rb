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

    # フレンド関係を解除する
    def unfollow
        Friend.find_by(follower_id: current_user.id, followed_id: params[:friend_id]).destroy
        Friend.find_by(follower_id: params[:friend_id], followed_id: current_user.id).destroy
        redirect_to root_path
    end

    # フレンドを承認する
    def approve
        Friend.find_by(follower_id: current_user.id, followed_id: params[:friend_id]).update(IsApproved: true)
        Friend.find_by(follower_id: params[:friend_id], followed_id: current_user.id).update(IsApproved: true)
        redirect_to root_path
    end

    def search
        #検索結果のレコードを返す(検索結果に自分自身が含まれていた場合はそれを除く)
        @user = User.where(username: params[:search]).where.not(id: current_user.id)
    end

    private
        def user_params
            params.require(:user).permit(:id, :username, :email, :friend_id)
        end


end
