class Link < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :url, presence: true, url: true, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 1000 }

  before_save :normalize_url

  private

  def normalize_url
    self.url = url.strip.downcase
  end
end