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
* Option 1: Use custom inputs
This is essentially designed to be a command line application to test right now. Please follow following instructions:
- rails c
- RobotMovementTester.call
- Follow on-screen instructions

* Option 2: Use provided test scenarios
- rake simulator:run[spec/fixtures/simulator/input1.txt]
- rake simulator:run[spec/fixtures/simulator/input2.txt]
- rake simulator:run[spec/fixtures/simulator/input3.txt]

* Option 3: Use custom file inputs
- Create a txt file in `spec/fixtures/simulator` folder and enter your inputs there
- Pass your file name in the command below
`rake simulator:run[spec/fixtures/simulator/<your_file_name>.txt]`

### Direction
```
  N
W   E
  S
```

### Running Test Cases
- rspec spec
