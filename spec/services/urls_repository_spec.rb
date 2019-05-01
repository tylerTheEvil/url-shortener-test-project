require 'rails_helper'

RSpec.describe UrlsRepository do
  let(:url) { Faker::Internet.url }
  let(:short_url) { "/#{Faker::Internet.slug}" }
  let(:full_url) { Hash[url: url, short_url: short_url] }

  describe '#create' do
    let(:short_url) { '/abc123' }

    subject do
      UrlsRepository.create(url)
    end

    before do
      allow_any_instance_of(ShortenUrlService).to receive(:short_url).and_return(short_url)
    end

    it 'creates new full url record' do
      expect(subject).to eq(full_url)
      expect(UrlsRepository.first).to eq(full_url)
    end

    it 'creates new record and store previos' do
      UrlsRepository.create(url)
      url = Faker::Internet.url
      expect(subject).to eq(full_url)
      expect(UrlsRepository.all.count).to eq(2)
    end
  end

  describe '#find_by_short_url' do
    subject do
      UrlsRepository.find_by_short_url(short_url)
    end

    before do
      allow_any_instance_of(ShortenUrlService).to receive(:short_url).and_return(short_url)
      UrlsRepository.create(url)
    end

    it 'returns firs full url record with matched short_url' do
      expect(subject).to eq(full_url)
    end
  end
end
