require 'rails_helper'

RSpec.describe AreaPositions::Create, type: :command do
  let!(:robot)   { create(:u_robot) }
  let!(:area)    { create(:area) }
  let(:initial)  { true }
  let(:position) { build(:area_position, u_robot: robot, area: area, x: 1, y: 1, face: :south) }

  subject { described_class.call(position, initial) }

  context 'when position is not in x bounds' do
    let(:position) { build(:area_position, u_robot: robot, area: area, x: -1, y: 1, face: :south) }

    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors.present?).to eq(true)
      expect(subject.errors[:cmd]).to include('New position X value is not within area bounds')
      expect(position.persisted?).to eq(false)
    end
  end

  context 'when position is not in y bounds' do
    let(:position) { build(:area_position, u_robot: robot, area: area, x: 1, y: -1, face: :south) }

    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors.present?).to eq(true)
      expect(subject.errors[:cmd]).to include('New position Y value is not within area bounds')
      expect(position.persisted?).to eq(false)
    end
  end

  context 'when position is valid' do
    it 'builds position' do
      expect(position.initial).to eq(nil)
      expect(subject.success?).to eq(true)
      expect(subject.errors.present?).to eq(false)
      expect(position.persisted?).to eq(true)
      expect(position.initial).to eq(true)
    end
  end
end
