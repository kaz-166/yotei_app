# "Participant" is the intermidiate model between the model "event" and "user". 
# This model has no column
class Participant < ApplicationRecord
    #イベント参加者管理の中間テーブル
    belongs_to :event, optional: true
    belongs_to :user, optional: true
end
