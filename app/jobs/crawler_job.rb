class CrawlerJob < ApplicationJob
  queue_as :default

  def perform(id)
    url = Url.find(id)
    response = HTTParty.get(url.source_url)
    title = Nokogiri::HTML(response.body).css('title').text
    url.update(title: title)
  end
end