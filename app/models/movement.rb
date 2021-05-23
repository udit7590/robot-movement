class Movement < ApplicationRecord
  enum step: {
    forward: 0, left: 1, right: 2
  }

  belongs_to :u_robot
  belongs_to :area

  after_initialize :assign_area
  after_initialize :assign_default_step

  private
  def assign_area
    self.area = u_robot&.current_position&.area
  end

  def assign_default_step
    self.step = 'forward' if step.blank?
  end
end
