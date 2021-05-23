class URobot < ApplicationRecord
  has_many :area_positions, dependent: :destroy
  has_many :movements, dependent: :destroy

  def current_position
    area_positions.last
  end

  def current_area
    current_position&.area
  end

  def placed?
    area_positions.where(initial: true).present?
  end
end
