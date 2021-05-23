module Movements
  class Forward < Movements::Create
    attr_reader :move_x, :move_y

    def run
      result = AreaPositions::Create.call(new_position, options: { skip_validation: true }) # Already validated
      result.success? ? success! : fail!
    end

    def valid?
      movable? && super
    end

    def movable?
      result = AreaPositions::Build.call(build_new_position)
      errors.merge!(result.errors) unless result.success?
      result.success?
    end

    def build_new_position
      coordinate_increment
      @new_position   ||= position.dup
      @new_position.x   = position.x + move_x.to_i
      @new_position.y   = position.y + move_y.to_i
      @new_position
    end

    def coordinate_increment
      @move_y = 1   if model.forward? && position.north?
      @move_y = -1  if model.forward? && position.south?
      @move_x = 1   if model.forward? && position.east?
      @move_x = -1  if model.forward? && position.west?
    end
  end
end
