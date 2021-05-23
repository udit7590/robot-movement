FactoryBot.define do  
  factory :movement do
    step { [:forward, :left, :right].sample }
    u_robot
  end
end
