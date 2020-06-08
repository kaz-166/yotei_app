require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # t.integer :user_id
   # t.string :name
   # t.datetime :start_time
   # t.datetime :end_time
   # t.string :location

   # 正しいデータ
  test "should be valid" do
    event = Event.new(user_id: 3, name: "Event", start_time: DateTime.now, end_time: DateTime.now, location: "sss")
    assert event.valid?
  end

  # イベント名は空ではいけない
  test 'Name of the event should be exist' do
    event = Event.new(user_id: 3, name: '', start_time: DateTime.now, end_time: DateTime.now, location: 'sss')
    assert event.invalid?
  end

   # 場所名は空ではいけない
   test 'Name of the location should be exist' do
    event = Event.new(user_id: 3, name: 'Event', start_time: DateTime.now, end_time: DateTime.now, location: '')
    assert event.invalid?
  end

  # イベント名は255文字以内ではいけない
  test 'Name of the event should be samller than 256' do
    event = Event.new(user_id: 3, name: 'e'*256, start_time: DateTime.now, end_time: DateTime.now, location: 'sss')
    assert event.invalid?
  end

  #場所名は255文字以内ではいけない
  test "Name of the location should be samller than 256" do
    event = Event.new(user_id: 3, name: "EVENT", start_time: DateTime.now, end_time: DateTime.now, location: "s"*256)
    assert event.invalid?
  end

end
