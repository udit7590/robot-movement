FactoryBot.define do  
  factory :area do
    name { '5x5 Table' }
    x_min { 0 }
    x_max { 5 }
    y_min { 0 }
    y_max { 5 }
  end
end
