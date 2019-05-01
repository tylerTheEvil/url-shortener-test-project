require 'rails_helper'

RSpec.describe ShortenUrlService do
  let(:url) { Faker::Internet.url }
  let(:short_url) { '/abc123' }

  subject { ShortenUrlService.new }

  it 'makes short url version' do
    expect(subject).to receive(:generate_short_url).and_return(short_url)
    expect(subject.short_url).to eq(short_url)
  end
end
