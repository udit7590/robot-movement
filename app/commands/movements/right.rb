module Movements
  class Right < Movements::Create
    def run
      result = AreaPositions::Create.call(build_new_position)
      result.success? ? success! : fail!
    end

    def build_new_position
      @new_position     ||= position.dup
      @new_position.face  = new_direction
      @new_position
    end

    def new_direction
      if position.north?
        :east
      elsif position.south?
        :west
      elsif position.east?
        :south
      else
        :north
      end
    end
  end
end
