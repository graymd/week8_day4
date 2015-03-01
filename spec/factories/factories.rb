FactoryGirl.define do
  factory :clinic do
    name "New Clinic Hospital"
    st_address "13456 Street"
    city "Charleston"
    state "SC"
  end
  factory :patient do
    clinic
    first_name "Maddie"
    last_name "Of The May"
    date_of_birth 12.years.ago
    description "sick of not getting lots of food"
    gender "female"
    blood_type "O-"
  end
end



