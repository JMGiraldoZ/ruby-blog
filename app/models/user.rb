class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :articles, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship',
            foreign_key: 'follower_id', dependent: :destroy 
  has_many :pasive_relationships, class_name: 'Relationship',
            foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :pasive_relationships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def following?(other_user)
    following.include?(other_user)
  end
  
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end
