module Robots
  class Report < BaseCommand
    attr_accessor :current_position

    def initialize(robot, *)
      @model            = robot
      @current_position = model.current_position
    end

    def run
      raise Positions::NotYetPlaced unless model.placed?

      context[:position] = current_position
      success!
    end
  end
end
