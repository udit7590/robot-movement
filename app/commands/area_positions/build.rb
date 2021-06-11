module AreaPositions
  class NotYetPlaced < StandardError
  end

  class Build < BaseCommand
    attr_accessor :robot, :area, :initial

    def initialize(position, initial=false, *)
      @model    = position
      @robot    = position.u_robot
      @area     = position.area
      @initial  = initial

      model.initial = initial
    end

    def run
      success!
    end

    def valid?
      super { bounds_valid? && not_colliding? }
    end

    def bounds_valid?
      debugger
      valid_x = begin
        model.x.to_i >= area.x_min &&
        model.x.to_i <= area.x_max
      end
      valid_y = begin
        model.y.to_i >= area.y_min &&
        model.y.to_i <= area.y_max
      end

      unless valid_x
        errors[:cmd] ||= []
        errors[:cmd] << 'New position X value is not within area bounds'
      end
      unless valid_y
        errors[:cmd] ||= []
        errors[:cmd] << 'New position Y value is not within area bounds'
      end
    end

    def not_colliding?
      debugger
      area.u_robots.each do |robot|
        cur = robot.current_position
        if cur.x.to_i == model.x.to_i && cur.y.to_i == model.y.to_i
          errors[:cmd] ||= []
          errors[:cmd] << "Another robot #{robot.name} is present on the position"
        end
      end
    end
  end
end
