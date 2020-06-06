# "Post" is the model of comment of an event. 
# This model has these columns
#   content:  text
#   event_id: integer
#   user_id:  integer
class Post < ApplicationRecord
    belongs_to :event
    # コメント内容は1文字以上200文字以下
    validates :content, presence: true
    validates :content, length: {minimum: Settings.post.content.min_length}
    validates :content, length: {maximum: Settings.post.content.max_length}
end
