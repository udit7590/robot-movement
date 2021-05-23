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
      super { bounds_valid? }
    end

    def bounds_valid?
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
  end
end
