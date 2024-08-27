class Url < ApplicationRecord
  validates :source_url, presence: true
  validates :output_url, presence: true, uniqueness: true

  after_create :crawl_source_url

  before_validation :generate_output_url

  def self.top_100
    order(visits: :desc).limit(100)
  end

  def increment_visits!
    update(visits: self.visits + 1)
  end

  private

  def generate_output_url
    self.output_url = get_new_output_url
    while Url.exists?(output_url: self.output_url)
      self.output_url = get_new_output
    end
  end

  def get_new_output_url
    SecureRandom.uuid.split("-").first
  end

  def crawl_source_url
    CrawlerJob.perform_later(self.id)
  end
end
