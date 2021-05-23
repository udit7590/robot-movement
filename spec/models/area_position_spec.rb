require 'rails_helper'

RSpec.describe Movement, type: :model do
  describe 'Assigns' do
    it 'assigns a default value north for position' do
      position = AreaPosition.new
      expect(position.face).to eq('north')
    end
  end
end
