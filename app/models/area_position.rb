class AreaPosition < ApplicationRecord
  belongs_to :area
  belongs_to :u_robot

  enum face: {
    north: 0, south: 1, east: 2, west: 3
  }

  scope :initial, -> { where(initial: true) }

  after_initialize :assign_default_face

  private
  def assign_default_face
    self.face = 'north' if face.blank?
  end
end
