class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    # taskとのリレーション
    has_many :tasks, dependent: :destroy
    # フォロー機能のリレーション
      # フォローする側
      has_many :relationships, foreign_key: "following_id", dependent: :destroy
      has_many :followings, through: :relationships, source: :follower
      # フォローされる側
      has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
      has_many :followers, through: :reverse_of_relationships, source: :following
    
    #フォロー済か否かを判定
    def already_followed?(user)
      reverse_of_relationships.find_by(following_id: user.id).present?
    end

end
