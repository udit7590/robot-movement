module Movements
  class Create < BaseCommand
    attr_reader :robot, :position, :new_position

    def initialize(movement, *)
      @model    = movement
      @robot    = movement.u_robot
      @position = robot.current_position
    end

    def run
      result = if model.forward?
        Movements::Forward.call(model)
      elsif model.left?
        Movements::Left.call(model)
      elsif model.right?
        Movements::Right.call(model)
      end
      if result.success?
       success!
      else
        errors.merge!(result.errors)
        fail!
      end
    end

    def valid?
      super { robot_placed? }
    end

    def robot_placed?
      unless robot.placed?
        errors[:cmd] ||= []
        errors[:cmd] << 'Robot is not yet placed on the area'
      end
    end
  end
end
