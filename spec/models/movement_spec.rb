require 'rails_helper'

RSpec.describe Movement, type: :model do
  describe 'Assigns' do
    let!(:robot)            { create(:u_robot) }
    let!(:area)             { create(:area) }
    let!(:initial_position) { create(:area_position, u_robot: robot, area: area, initial: true) }

    it 'assigns a default value forward for movement' do
      movement = Movement.new
      expect(movement.step).to eq('forward')
    end

    it 'picks area from u_robot association' do
      movement = Movement.new(u_robot: robot)
      expect(movement.area.id).to eq(area.id)
    end
  end
end
