class Event < ApplicationRecord
#イベント参加者のデータベース関連
has_many :participants, class_name:  "Participant",
                        foreign_key: "event_id",
                        dependent:   :destroy
has_many :users, through: :participants

validate :date_cannot_be_in_past, :start_date_cannot_be_bigger_than_end_date

  #参加者を追加する
  def self.add_user(id, user_id)
    if Participant.where(event_id: id, user_id: user_id).empty?
      Participant.create(event_id: id, user_id: user_id)
    end
  end

  #参加者を削除する
  def self.delete_user(id, user_id)
    p = Participant.find_by(event_id: id, user_id: user_id)
    if p != nil
        Participant.destroy(p.id)
    end
  end

  private 
    #バリデーション、過去の日程は指定できない
    def date_cannot_be_in_past
      if self.start_time < Date.today || self.end_time < Date.today
        errors.add(:past_date, "過去の日付は指定できません")
      end
    end

    #バリデーション、開始日時は終了日時より前の時間を指定する必要がある
    def start_date_cannot_be_bigger_than_end_date
      if self.start_time > self.end_time
        errors.add(:date_validation, "開始日時は終了日時より前に設定する必要があります")
      end
    end



end
