class Link < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :url, presence: true, url: true, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 1000 }

  before_save :normalize_url

  def score
    votes.sum(:value)
  end

  def self.rank
    all.sort_by { |link| [-link.score, link.created_at] }
  end

  private

  def normalize_url
    self.url = url.strip.downcase
  end
end