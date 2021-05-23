class URobot < ApplicationRecord
  has_many :area_positions
  has_many :movements

  def current_area
    current_position&.area
  end

  def current_position
    area_positions.last
  end

  def placed?
    area_positions.where(initial: true).present?
  end
end
