require 'rails_helper'

RSpec.describe Movements::Create, type: :command do
  let!(:robot)    { create(:u_robot) }
  let!(:area)     { create(:area) }
  let!(:position) { create(:area_position, u_robot: robot, area: area, initial: true, x: 2, y: 2, face: :south) }
  let!(:movement) { create(:movement, u_robot: robot, step: :forward) }

  subject { described_class.call(movement) }

  context 'when robot not yet placed' do
    before { position.destroy! }

    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors.present?).to eq(true)
      expect(subject.errors[:cmd]).to include('Robot is not yet placed on the area')
    end
  end

  context 'when moved forward' do
    it 'moves robot' do
      expect(subject.success?).to eq(true)
      expect(subject.errors.present?).to eq(false)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(1)
      expect(current_position.face).to eq('south')

      result = described_class.call(movement.dup)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(0)
      expect(current_position.face).to eq('south')

      result = described_class.call(movement.dup)
      expect(result.success?).to eq(false)
      expect(result.errors.present?).to eq(true)
      expect(result.errors[:cmd]).to include('New position Y value is not within area bounds')
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(0)
      expect(current_position.face).to eq('south')
    end
  end

  context 'when moved left' do
    let!(:movement) { create(:movement, u_robot: robot, step: :left) }

    it 'rotates robot left by 90 degree' do
      expect(subject.success?).to eq(true)
      expect(subject.errors.present?).to eq(false)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('east')

      result = described_class.call(movement.dup)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('north')

      result = described_class.call(movement.dup)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('west')

      result = described_class.call(movement.dup)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('south')

      result = described_class.call(movement.dup)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('east')
    end
  end

  context 'when moved right' do
    let!(:movement) { create(:movement, u_robot: robot, step: :right) }

    it 'rotates robot right by 90 degree' do
      expect(subject.success?).to eq(true)
      expect(subject.errors.present?).to eq(false)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('west')

      result = described_class.call(movement.dup)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('north')

      result = described_class.call(movement.dup)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('east')

      result = described_class.call(movement.dup)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('south')

      result = described_class.call(movement.dup)
      current_position = robot.current_position
      expect(current_position.x).to eq(2)
      expect(current_position.y).to eq(2)
      expect(current_position.face).to eq('west')
    end
  end
end
