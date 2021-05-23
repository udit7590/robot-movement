module Movements
  class Left < Movements::Create
    def run
      result = AreaPositions::Create.call(build_new_position)
      result.success? ? success! : fail!
    end

    def build_new_position
      @new_position     ||= position.dup
      @new_position.face    = new_direction
      @new_position.initial = false
      @new_position
    end

    def valid?
      true
    end

    def new_direction
      if position.north?
        :west
      elsif position.south?
        :east
      elsif position.east?
        :north
      else
        :south
      end
    end
  end
end
