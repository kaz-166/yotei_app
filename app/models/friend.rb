# "Friend" is the intermidiate model between the model one "user" and another "user". 
# This model has no column
class Friend < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :followed, class_name: 'User'
end
