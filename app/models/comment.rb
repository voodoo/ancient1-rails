class Comment < ApplicationRecord
  belongs_to :link
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :content, presence: true

  def score
    votes.sum(:value)
  end

  def upvote(user)
    votes.create(user: user, value: 1)
  end

  def downvote(user)
    votes.create(user: user, value: -1)
  end
end