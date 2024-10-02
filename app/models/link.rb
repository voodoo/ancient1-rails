class Link < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true, url: true, uniqueness: true

  def score
    votes.sum(:value)
  end

  def upvote(user)
    votes.create(user: user, value: 1)
  end

  def downvote(user)
    votes.create(user: user, value: -1)
  end

  # Calculates the ranking of the link based on its age
  #
  # The ranking is a value between 0 and 1, representing the proportion of time
  # left within the first 24 hours of the link's creation. A newly created link
  # will have a ranking of 1, and it decreases linearly over time until it reaches 0
  # after 24 hours.
  #
  # @return [Float] The ranking value, rounded to 4 decimal places
  def ranking
    twenty_four_hours = 24 * 60 * 60
    time_since_creation = Time.now.to_i - created_at.to_i
    time_left = [twenty_four_hours - time_since_creation, 0].max
    (time_left.to_f / twenty_four_hours).round(4)
  end

end