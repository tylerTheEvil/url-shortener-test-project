require 'rails_helper'

RSpec.describe 'Url Shortener request', type: :request do
  let(:url) { Faker::Internet.url }
  let(:short_url) { "/#{Faker::Internet.slug}" }
  let(:full_url) { Hash[url: url, short_url: short_url] }

  before do
    allow_any_instance_of(ShortenUrlService).to receive(:short_url).and_return(short_url)
  end

  it 'successfully creates shortened url' do
    params = { url: url }
    post '/shortened_urls', params: params
    expect(response).to have_http_status(:created)
    expect(UrlsRepository.all.count).to eq(1)
    expect(UrlsRepository.first).to eq(full_url)
    expect(response.body).to eq(full_url.to_json)
  end
end
