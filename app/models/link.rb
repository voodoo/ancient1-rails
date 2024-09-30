class Link < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true, url: true

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