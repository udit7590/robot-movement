require 'rails_helper'

RSpec.describe Robots::Report, type: :command do
  let!(:robot)            { create(:u_robot) }
  let!(:area)             { create(:area) }
  let(:initial_position)  { create(:area_position, u_robot: robot, area: area, initial: true, x: 2, y: 1, face: :south) }
  let(:position)          { create(:area_position, u_robot: robot, area: area, initial: false, x: 1, y: 1, face: :west) }

  subject { described_class.call(robot) }

  context 'when robot is not placed' do
    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors.present?).to eq(true)
      expect(subject.errors[:cmd]).to include('Robot is not yet placed on the area')
    end
  end

  context 'when robot is placed' do
    before { initial_position }
    it 'returns position' do
      expect(subject.success?).to eq(true)
      expect(subject.errors.present?).to eq(false)

      position = subject.context[:position]
      expect(position.x).to eq(2)
      expect(position.y).to eq(1)
      expect(position.face).to eq('south')
    end
  end
end
