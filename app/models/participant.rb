class Participant < ApplicationRecord
    #イベント参加者管理の中間テーブル
    belongs_to :events, optional: true
    belongs_to :users, optional: true
end
