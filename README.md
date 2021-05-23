# README

### Architecture
* Area (x_min, x_max, y_min, y_max, name, type)
* Robot (name) - has_many :movements, :positions
* Position (x, y, face, initial) - references :robot, :area
* Movement (step) - references :robot, :area

### Starting Project
* bundle install
* rails db:create; rails db:migrate OR rails db:schema:load; rails db:seed
* rails s

### Direction
  N
W   E
  S
