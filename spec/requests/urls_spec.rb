require 'rails_helper'

RSpec.describe "Urls", type: :request, allow_other_host: true do

  describe 'GET /urls' do
    it 'returns a list of the top 100 urls' do
      url1 = Url.create(source_url: 'http://example1.com', visits: 100)
      url2 = Url.create(source_url: 'http://example2.com', visits: 50)

      get '/urls'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.body).to eq([url1, url2].to_json)
    end
  end

  describe 'POST /urls' do
    it 'creates a new url' do
      post '/url', params: { url: 'http://example.com' }

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.body).to include('output_url')
    end
  end

  describe 'GET /urls/:id' do
    it 'redirects to the original url' do
      url = Url.create(source_url: 'http://example.com')
      get "/url/#{url.id}"

      expect(response).to redirect_to(url.source_url)
    end
  end
end
