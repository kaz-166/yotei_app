class PostsController < ApplicationController
    
    def create
      Post.create(content: post_params[:content], event_id: post_params[:event_id], user_id: current_user.id)
      redirect_to event_path(post_params[:event_id])
    end

    def delete
    end

    private
      #strong parameters
      def post_params
        params.require(:post).permit(:content, :event_id)
      end
end
