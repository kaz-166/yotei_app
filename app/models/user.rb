class User < ApplicationRecord
  #フレンドのデータベース関連
  has_many :friends, class_name:  "Friend",
                     foreign_key: "follower_id",
                     dependent:   :destroy
  has_many :following, through: :friends, source: :followed
  has_many :followed, through: :friends, source: :follower
  
  #イベント参加者のデータベース関連
  has_many :participants
  has_many :events, through: :participants
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, :confirmable
          

  mount_uploader :img, ImgUploader
  attr_accessor :login

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
       user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        username: auth.info.name,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
      )
    end
    user
  end

  def self.follow(follower_id, followed_id)
    # すでにデータベースに登録されていなければ新規登録する
    if (Friend.where(follower_id: follower_id, followed_id: followed_id).empty?)&&
       (Friend.where(follower_id: followed_id, followed_id: follower_id).empty?)
      Friend.create(follower_id: follower_id, followed_id: followed_id)
      Friend.create(follower_id: followed_id, followed_id: follower_id)
    end
  end

  def self.unfollow
  end

  # 承認済みのフレンドを返すメソッド
  def self.friend(id)
    User.find(id).following.where("friends.IsApproved = ?", true)
  end

  # 未承認を含めたフレンドを返すメソッド
  def self.potential_friend(id)
    User.find(id).following
  end

  # 指定されたユーザのフレンド関係が承認されているかを返すメソッド
  def self.is_approved?(self_id, friend_id)
    User.find(self_id).friends.find_by(followed_id: friend_id).IsApproved
  end

  # 指定されたフレンドを承認する
  def self.approve(self_id, friend_id)
    User.find(self_id).friends.find_by(followed_id: friend_id).update(IsApproved: true)
    User.find(friend_id).friends.find_by(followed_id: self_id).update(IsApproved: true)
  end

     
  private 
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end