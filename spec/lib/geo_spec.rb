require 'rails_helper'

describe Geo do
  describe '#geocode' do

    shared_examples 'locatable' do
      it 'return [latitude longitude]' do
        expect(location).to eq [35.6571635, 139.7032207]
      end
    end

    context 'when english language' do
      let(:location) { Geo.geocode('3-21-3 Shibuya, Shibuya-ku, Tokyo') }
      it_behaves_like 'locatable'
    end

    context 'when japanese language' do
      let(:location) { Geo.geocode('東京都渋谷区渋谷３丁目２１−３') }
      it_behaves_like 'locatable'
    end

    context 'when separate space' do
      let(:location) { Geo.geocode('東京都 渋谷区 渋谷 ３丁目２１−３') }
      it_behaves_like 'locatable'
    end

    context 'when separate comma' do
      let(:location) { Geo.geocode('東京都, 渋谷区, 渋谷３丁目２１−３') }
      it_behaves_like 'locatable'
    end

    context 'when half-size integer' do
      let(:location) { Geo.geocode('東京都 渋谷区 渋谷3-21-3') }
      it_behaves_like 'locatable'
    end

  end
end