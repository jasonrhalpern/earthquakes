require 'rails_helper'

describe Earthquake do
  let(:earthquake) { Earthquake.new }
  let(:existing_earthquake){ create(:earthquake) }

  describe 'validations' do
    it 'is invalid without a time_of' do
      expect{ earthquake.valid? }.to change{ earthquake.errors[:time_of] }.to include("can't be blank")
    end

    it 'is invalid without a magnitude' do
      expect{ earthquake.valid? }.to change{ earthquake.errors[:magnitude] }.to include("can't be blank")
    end

    it 'is invalid without a latitude' do
      expect{ earthquake.valid? }.to change{ earthquake.errors[:latitude] }.to include("can't be blank")
    end

    it 'is invalid without a longitude' do
      expect{ earthquake.valid? }.to change{ earthquake.errors[:longitude] }.to include("can't be blank")
    end

    it 'is invalid without a place' do
      expect{ earthquake.valid? }.to change{ earthquake.errors[:place] }.to include("can't be blank")
    end

    it 'is invalid if the earthquake already exists at this time and place' do
      earthquake.time_of = existing_earthquake.time_of
      earthquake.place = existing_earthquake.place
      expect{ earthquake.valid? }.to change{ earthquake.errors[:place] }.to include("is already saved for this time and location.")
    end
  end
end