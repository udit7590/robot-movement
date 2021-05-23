module Movements
  class Forward < Movements::Create
    attr_reader :move_x, :move_y

    def run
      result = AreaPositions::Create.call(build_new_position, false)
      if result.success?
        context[:position] =result.model
        success!
      else
        errors.merge!(result.errors)
        fail!
      end
    end

    def valid?
      super
    end

    private
    def build_new_position
      coordinate_increment
      @new_position   ||= position.dup
      @new_position.x   = position.x.to_i + move_x.to_i
      @new_position.y   = position.y.to_i + move_y.to_i
      @new_position
    end

    def coordinate_increment
      @move_y = 1   if position.north?
      @move_y = -1  if position.south?
      @move_x = 1   if position.east?
      @move_x = -1  if position.west?
    end
  end
end
