# "Post" is the model of comment of an event. 
# This model has these columns
#   content:  text
#   event_id: integer
#   user_id:  integer
class Post < ApplicationRecord
    belongs_to :event
    # A comment must be smaller than 1 word and bigger than 200 words.
    validates :content, presence: true
    validates :content, length: {minimum: Settings.post.content.min_length}
    validates :content, length: {maximum: Settings.post.content.max_length}
end
