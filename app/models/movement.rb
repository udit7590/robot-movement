class Movement < ApplicationRecord
  enum step: {
    forward: 0, left: 1, right: 2
  }

  belongs_to :u_robot
  belongs_to :area

  before_validation :assign_area
  before_validation :assign_default_step

  private
  def assign_area
    self.area = u_robot.current_position&.area
  end

  def assign_default_step
    forward! if step.blank?
  end
end
