class PostsController < ApplicationController
    
    def create
      @post = Post.new(content: post_params[:content], event_id: post_params[:event_id], user_id: current_user.id)
      if @post.save
        redirect_to event_path(post_params[:event_id])
      else
        @post = Post.where(event_id: post_params[:event_id])
        @event = Event.find(post_params[:event_id])
        render 'events/show'
      end
    end

    def destroy
      Post.find(params[:id]).destroy
      # 削除あとは元のイベントページにリダイレクト
      redirect_back(fallback_location: root_path)
    end

    private
      # strong parameters
      def post_params
        params.require(:post).permit(:id, :content, :event_id)
      end
end
