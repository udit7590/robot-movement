require 'rails_helper'

RSpec.describe URobot, type: :model do
  describe 'Instance Methods' do
    let!(:robot)            { create(:u_robot) }
    let!(:area)             { create(:area) }
    let(:initial_position)  { create(:area_position, u_robot: robot, area: area, initial: true) }
    let(:position)          { create(:area_position, u_robot: robot, area: area, initial: false, x: 1, y: 1, face: :west) }

    describe '#current_position' do
      it 'returns current position' do
        expect(robot.current_position).to eq(nil)
        initial_position
        expect(robot.current_position.id).to eq(initial_position.id)
        position
        expect(robot.current_position.id).to eq(position.id)
      end
    end

    describe '#current_area' do
      it 'returns current area' do
        expect(robot.current_area).to eq(nil)
        initial_position
        expect(robot.current_area.id).to eq(area.id)
        position
        expect(robot.current_area.id).to eq(area.id)
      end
    end

    describe '#placed?' do
      it 'returns if robot is placed on area' do
        expect(robot.placed?).to eq(false)
        initial_position
        expect(robot.placed?).to eq(true)
        position
        expect(robot.placed?).to eq(true)
      end
    end
  end
end
