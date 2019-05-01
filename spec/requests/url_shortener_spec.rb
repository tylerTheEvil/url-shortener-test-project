require 'rails_helper'

RSpec.describe 'URL Shortener', type: :request do
  it 'successfully creates shortened url' do
    params = { url: "http://www.farmdrop.com" }
    post '/shortened_urls', params: params
    expect(response).to have_http_status(:created)
  end
end
