class RobotMovementTester
  attr_accessor :robot, :area

  def self.call
    new.call
  end

  def initialize
    @robot = URobot.first
    @area  = Area.first
  end

  def call
    initial_debug_level = Rails.logger.level
    Rails.logger.level = Logger::ERROR

    welcome
    help
    user_inputs

    Rails.logger.level = initial_debug_level
  end

  def welcome
    p '#'*50
    p "Welcome to Robot Movement Simulator"
    p 'Type HELP to get help on commands'
    p '#'*50
  end

  def user_inputs
    p 'FIRST INPUT'
    input = gets.chomp.strip
    while(input.present? && input.upcase != 'EXIT')
      case input.upcase
      when 'MOVE'
        mmt = Movements::Create.call(movement(input))
        response(mmt)
      when 'LEFT'
        mmt = Movements::Create.call(movement(input))
        response(mmt)
      when 'RIGHT'
        mmt = Movements::Create.call(movement(input))
        response(mmt)
      when 'HELP'
        help
      when 'EXIT'
      when ''
      when 'REPORT'
        cmd = Robots::Report.call(robot)
        report(cmd)
      else
        splits = input.split(' ')
        if splits.size > 2
          p 'INVALID INPUT!'
          help
        else
          val = splits[1]
          x, y, face = val.split(',').map(&:strip)
          cmd = AreaPositions::Create.call(position(x, y, face))
          response(cmd)
        end
      end

      p 'NEXT INPUT'
      input = gets.chomp
    end
  end

  def movement(direction)
    case direction
    when 'MOVE'
      step = :forward
    when 'RIGHT'
      step = :right
    else
      step = :left
    end
    Movement.create(u_robot: robot, step: step)
  end

  def position(x, y, face)
    AreaPosition.new(u_robot: robot, face: face.downcase, x: x.to_i, y: y.to_i, area: area)
  end

  def response(command)
    if command.success?
      display_success
    else
      display_errors(command.errors)
    end
  end

  def display_success
    p 'SUCCESS!'
  end

  def display_errors(errors)
    p 'ERROR!'
    messages = []
    errors.each do |key, value|
      if key == :base || key == :cmd
        messages << errors[key]
      else
        messages = messages + Array.wrap(value).map { |value| "#{key} #{value}" }
      end
    end
    p messages.flatten.join("\n")
  end

  def report(cmd)
    pos = cmd.context[:position]
    if pos.blank?
      p 'Robot not placed anywhere yet!'
    else
      p "X: #{pos.x}, Y: #{pos.y}, FACE: #{pos.face}"
    end
  end

  def help
    p ''
    p '*'*50
    p 'COMMAND OPTIONS'
    p '#'*50
    p 'PLACE <X>,<Y>,<DIRECTION>'
    p '<MOVEMENT>'
    p 'REPORT'
    p 'HELP'
    p 'EXIT'
    p '#'*50
    p 'X,Y = INTEGER'
    p 'DIRECTION = NORTH | SOUTH | EAST | WEST'
    p 'MOVEMENT = LEFT | RIGHT | MOVE'
    p '*'*50
    p ''
  end
end
