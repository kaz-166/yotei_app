class Event < ApplicationRecord
#イベント参加者のデータベース関連
has_many :participants, class_name:  "Participant",
                        foreign_key: "event_id",
                        dependent:   :destroy
has_many :users, through: :participants, source: :events

  #参加者を追加する
  def self.add_user(id, user_id)
    if Participant.where(event_id: id, user_id: user_id).empty?
      Participant.create(event_id: id, user_id: user_id)
    end
  end

  #参加者を削除する
  def self.delete_user(id, user_id)
    Participant.where(event_id: id, user_id: user_id).destroy
  end



end
