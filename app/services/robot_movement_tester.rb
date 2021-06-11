class RobotMovementTester
  attr_accessor :robot, :area, :file

  def self.call(filename=nil)
    new(filename).call
  end

  def initialize(filename=nil)
    @file  = filename
    @robot = URobot.first
    @area  = Area.first
  end

  def call
    initial_debug_level = Rails.logger.level
    Rails.logger.level = Logger::ERROR

    welcome

    if file.present?
      file_inputs
    else
      help
      user_inputs
    end

    Rails.logger.level = initial_debug_level
  end

  def welcome
    p '#'*50
    p "Welcome to Robot Movement Simulator"
    p 'Type HELP to get help on commands'
    p '#'*50
  end

  def file_inputs
    File.readlines(file).each do |input|
      p '-'*50
      p "> #{input}"
      p '-'*50
      input_processor(input.chomp.strip)
    end
  end

  def user_inputs
    p 'FIRST INPUT'
    input = gets.chomp.strip

    while input.present? && input.upcase != 'EXIT'
      input_processor(input)
      p 'NEXT INPUT'
      input = gets.chomp
    end
  end

  def input_processor(input)
    return if input.blank? || input.upcase == 'EXIT'

    robot_name  = input.split(' ')[0]
    if robot_name != 'ROBOT'
      input = input.split(' ')[1..-1].join(' ')
      @robot = URobot.find_by(name: robot_name.downcase)
      raise 'No such robot' if @robot.blank?
    end

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
    when 'REPORT'
      cmd = Robots::Report.call(robot)
      report(cmd)
    when /^(ROBOT)/
      name = input.split(' ')[1]
      @robot = URobot.create!(name: name.downcase)
    else
      splits = input.split(' ')
      if splits.size > 2
        p 'INVALID INPUT!'
        help
      else
        val = splits[1]
        x, y, face = val.split(',').map(&:strip)
        cmd = AreaPositions::Create.call(position(x, y, face), true)
        response(cmd)
      end
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
    p '?'*50
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
    p '?'*50
  end

  def report(cmd)
    pos = cmd.context[:position]
    if pos.blank?
      p 'Robot not placed anywhere yet!'
    else
      p "#{pos.x}, #{pos.y}, #{pos.face.upcase}"
    end
  end

  def help
    p ''
    p '*'*50
    p 'COMMAND OPTIONS'
    p '#'*50
    p '1. PLACE <X>,<Y>,<DIRECTION>'
    p '2. <MOVEMENT>'
    p '3. REPORT'
    p '4. HELP'
    p '5. EXIT (or leave blank)'
    p '6. ROBOT <name>'
    p '#'*50
    p 'X,Y = INTEGER'
    p 'DIRECTION = NORTH | SOUTH | EAST | WEST'
    p 'MOVEMENT = LEFT | RIGHT | MOVE'
    p 'name = Any name for new robot to start'
    p '*'*50
    p ''
  end
end
