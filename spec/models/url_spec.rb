require 'rails_helper'

RSpec.describe Url, type: :model do

  describe '#generate_output_url' do
    it 'generates a unique output_url' do
      url1 = Url.create(source_url: 'http://example.com')
      url1.output_url = 'abc123'
      url2 = Url.create(source_url: 'http://example.com')
      url2.output_url = 'abc123'

      expect(url1.save).to eq(true)
      expect(url2.output_url).not_to eq(url1.output_url)
    end
  end

  describe '#crawl_source_url' do
    it 'enqueues a CrawlSourceUrlJob' do
      url = Url.create(source_url: 'http://example.com')

      expect { url.crawl_source_url }.to have_enqueued_job(CrawlSourceUrlJob)
    end
  end
end
