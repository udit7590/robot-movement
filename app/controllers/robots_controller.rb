class RobotsController < ApplicationController
  def current
    @robot  = URobot.first
    @area   = @robot.positions.last&.area.presence || Area.first
  end
end
