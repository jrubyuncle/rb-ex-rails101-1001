class Group < ActiveRecord::Base
  validates :title, presence: true

  has_many :posts, dependent: :destroy

  belongs_to :owner, class_name: "User", foreign_key: :user_id
  #belongs_to :user

  has_many :group_users
  has_many :members, through: :group_users, source: :user

  def editable_by_user?(user)
      user == owner
  end

  def include_member?(user)
    members.include?(user)
  end
end
