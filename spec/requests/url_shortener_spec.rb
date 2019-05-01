require 'rails_helper'

RSpec.describe 'Url Shortener request', type: :request do
  let(:url) { Faker::Internet.url }
  let(:short_url) { "/#{Faker::Internet.slug}" }
  let(:full_url) { Hash[url: url, short_url: short_url] }

  before do
    allow_any_instance_of(ShortenUrlService).to receive(:short_url).and_return(short_url)
  end
  
  describe '#create' do
    it 'successfully creates shortened url' do
      params = { url: url }
      post '/shortened_urls', params: params
      expect(response).to have_http_status(:created)
      expect(UrlsRepository.all.count).to eq(1)
      expect(UrlsRepository.first).to eq(full_url)
      expect(response.body).to eq(full_url.to_json)
    end
  end

  describe '#show' do
    before do
      UrlsRepository.create(url)
    end

    it 'redirects to basic url if matched short url record' do
      get short_url
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(url)
    end

    it 'return 404 status if no records matched' do
      get '/example'
      expect(response).to have_http_status(:not_found)
    end
  end
end
