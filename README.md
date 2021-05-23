# README

### Architecture
* Area (x_min, x_max, y_min, y_max, name, type)
* URobot (name) - has_many :movements, :positions
* AreaPosition (x, y, face, initial) - references :robot, :area
* Movement (step) - references :robot, :area

### Starting Project
* bundle install
* rails db:create; rails db:migrate OR rails db:schema:load; rails db:seed
* rails s

### How to Test?
This is essentially designed to be a command line application to test right now. Please follow following instructions:
- rails c
- RobotMovementTester.call
- Follow on-screen instructions

### Direction
```
  N
W   E
  S
```

### Running Test Cases
- rspec spec
