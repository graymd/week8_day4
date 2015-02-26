require 'rails_helper'

RSpec.describe Medication, type: :model do 
  subject do
    Medication.new({
      name: "pill",
      company: "the pill co",
      adverse_reactions: "abdominal pain",
      generic_option: true
    })
  end

  let(:patient) do
    Patient.new({
      first_name: "Kitter",
      last_name: "Cat",
      description: "sick",
      gender: "male",
      blood_type: "O-",
      date_of_birth: 10/14/2001
      })
  end

  it "should have a name" do
    expect(subject.name).to eq('pill')
  end

  it "should NOT have a name" do
    expect(subject.name).not_to eq(nil)
  end

  it "should have a company" do
    expect(subject.company).to eq('the pill co')
  end

  it "should NOT have a company" do
    expect(subject.company).not_to eq(nil)
  end

  it "should have a generic_option" do
    expect(subject.generic_option).to eq(true)
  end

  it "should NOT have a generic_option" do
    expect(subject.generic_option).not_to eq(false)
  end

  it "should validate when we have a name" do
    subject.save
    expect(subject.valid?).to eq(true)
  end

  it "should validate when we do NOT have a name" do
    medication = Medication.new
    medication.save
    expect(medication.errors.full_messages).to include("Name can't be blank")
  end

  it "should return whether a medication has a generic or not" do
    expect(subject.has_generic?).to eq("yes")
  end

  it "should return whether a medication has a generic or not" do
    expect(subject.has_generic?).not_to eq("no")
  end

  it "should have ability to add patient" do
    subject.patients << patient
    expect(subject.patients.length).to eq(1)
  end

  it {should have_many(:patients)}

  it {should have_many(:patient_medications)}

  
end
