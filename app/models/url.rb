class Url < ApplicationRecord
  validates :source_url, presence: true
  validates :output_url, presence: true, uniqueness: true

  before_validation :generate_output_url

  def generate_output_url
    self.output_url = get_new_output_url
    while Url.exists?(output_url: self.output_url)
      self.output_url = get_new_output
    end
  end

  def get_new_output_url
    SecureRandom.uuid.split("-").first
  end
end
