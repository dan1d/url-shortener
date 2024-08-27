require 'rails_helper'

RSpec.describe CrawlerJob, type: :job do
  describe '#perform' do
    it 'updates the url title' do
      url = Url.create(source_url: 'http://example.com')
      stub_request(:get, url.source_url).to_return(body: '<title>Example</title>')

      CrawlerJob.perform_now(url.id)

      expect(url.reload.title).to eq('Example')
    end
  end
end
