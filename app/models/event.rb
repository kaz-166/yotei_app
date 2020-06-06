# "Event" is the model of an event. 
# This model has these columns
#   abstract:   text
#   start_time: datetime
#   end_time:   datetime
#   name:       string
#   location:   string 
class Event < ApplicationRecord
has_many :participants
has_many :users, through: :participants
has_many :posts, dependent: :destroy

validate :date_cannot_be_in_past, :start_date_cannot_be_bigger_than_end_date

  # This is a method that approve the participant. 
  def self.add_user(id, user_id)
    if Participant.where(event_id: id, user_id: user_id).empty?
      Participant.create(event_id: id, user_id: user_id)
    end
  end

  # This is a method that delete the participant. 
  def self.delete_user(id, user_id)
    p = Participant.find_by(event_id: id, user_id: user_id)
    if p != nil
        Participant.destroy(p.id)
    end
  end

  private 
    # Validation: Event must not be past time.
    def date_cannot_be_in_past
      if self.start_time < Date.today || self.end_time < Date.today
        errors.add(:past_date, "過去の日付は指定できません")
      end
    end

    # Validation: Event's start time must be before end time.
    def start_date_cannot_be_bigger_than_end_date
      if self.start_time > self.end_time
        errors.add(:date_validation, "開始日時は終了日時より前に設定する必要があります")
      end
    end



end
