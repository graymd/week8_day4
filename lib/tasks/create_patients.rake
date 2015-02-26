task create_patient: :environment do
  100.times do
    med_data = Medication.create!({
      name: Faker::Name.first_name + "icillin",
      company: Faker::Company.name,
      adverse_reactions: Faker::Lorem.sentence,
      generic_option: [true, false].sample
    })
    Patient.create!({
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      date_of_birth: Faker::Date.between(70.years.ago, 10.years.ago),
      description: Faker::Lorem.sentence,
      gender: ["male", "female"].sample,
      blood_type: [
        "O-",
        "O+",
        "A-",
        "A+",
        "B-",
        "B+",
        "AB-", 
        "AB+" 
      ].sample,
      medications: [
        med_data
      ],
      clinic_id: 1
    })
  end
end