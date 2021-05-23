FactoryBot.define do  
  factory :area_position do
    x { 0 }
    y { 0 }
    face { :north }

    u_robot
    area
  end
end
