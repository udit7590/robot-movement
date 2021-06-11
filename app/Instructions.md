New
Toy Robot Simulator - with multiple robots
------------------------------------------

Description
-----------

The ability to add multiple robots to the table top.
All the other requirements stay the same as the original with the additional:
- Any movement that would result in the robot landing on top of another robot must be prevented.


Extend the application to read:

HADRIAN PLACE X,Y,F
HADRIAN MOVE
HADRIAN LEFT
AHMED PLACE X,Y,F
AHMED MOVE
AHMED LEFT
HADRIAN RIGHT
HADRIAN REPORT
AHMED REPORT

All requirements from the original specification hold expect that each command is preceded with the robots name.
