module Movements
  class Create < BaseCommand
    attr_reader :robot, :position, :new_position

    def initialize(movement, *)
      @model    = movement
      @robot    = movement.u_robot
      @position = robot.current_position
    end

    def run
      result = call_movement_action

      if result.success?
        model.save!
        success!
      else
        errors.merge!(result.errors)
        fail!
      end
    end

    def valid?
      super { robot_placed? && valid_position? }
    end

    private
    def call_movement_action
      if model.forward?
        Movements::Forward.call(model)
      elsif model.left?
        Movements::Left.call(model)
      elsif model.right?
        Movements::Right.call(model)
      end
    end

    def robot_placed?
      unless robot.placed?
        errors[:cmd] ||= []
        errors[:cmd] << 'Robot is not yet placed on the area'
      end
      errors.blank?
    end

    # NOTE: This should never be reachable. We can add error notifier in case code reaches here
    def valid_position?
      unless position.present?
        errors[:cmd] ||= []
        errors[:cmd] << 'Robot current position is unknown for some reason'
      end
      errors.blank?
    end
  end
end
