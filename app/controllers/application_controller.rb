class ApplicationController < ActionController::Base
  def find_robot
    @robot = URobot.first
  end

  def find_area
    @area = Area.first
  end
end
