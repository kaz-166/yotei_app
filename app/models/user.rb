class User < ApplicationRecord
  has_many :friends, class_name:  "Friend",
                     foreign_key: "follower_id",
                     dependent:   :destroy
  has_many :following, through: :friends, source: :followed
  has_many :followed, through: :friends, source: :follower
  
  # relation about participants of an event.
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
    # If given ID is not registerd, the database save the ID.
    if (Friend.where(follower_id: follower_id, followed_id: followed_id).empty?)&&
       (Friend.where(follower_id: followed_id, followed_id: follower_id).empty?)
      Friend.create(follower_id: follower_id, followed_id: followed_id)
      Friend.create(follower_id: followed_id, followed_id: follower_id)
    end
  end

  def self.unfollow
  end

  # This method returns friends who is approved.
  def self.friend(id)
    User.find(id).following.where("friends.\"IsApproved\" = ?", true)
  end

  # This method returns friends regardless of approval.
  def self.potential_friend(id)
    User.find(id).following
  end

  # This method returns whether the friend is approved.
  def self.is_approved?(self_id, friend_id)
    User.find(self_id).friends.find_by(followed_id: friend_id).IsApproved
  end

  # this method approve the designated ID
  def self.approve(self_id, friend_id)
    User.find(self_id).friends.find_by(followed_id: friend_id).update(IsApproved: true)
    User.find(friend_id).friends.find_by(followed_id: self_id).update(IsApproved: true)
  end

     
  private 
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end