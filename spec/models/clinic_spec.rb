require 'rails_helper'

RSpec.describe Clinic, type: :model do

  subject do
    Clinic.new({
      name: "Some clinic",
      st_address: "Cool Street",
      city: "Cool George",
      state: "SC" 
    })
  end

  let(:doctor) do
    Doctor.new({
      doctor_name: "Kitter"
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
    expect(subject.name).to eq('Some clinic')
  end

  it "should NOT have a name" do
    clinic = Clinic.new
    expect(clinic.name).not_to eq("Some Clinic")
  end

  it "should have a st_address" do
    expect(subject.st_address).to eq('Cool Street')
  end

  it "should NOT have a st_address" do
    clinic = Clinic.new
    expect(clinic.st_address).not_to eq('Cool Street')
  end

  it "should have a city" do
    expect(subject.city).to eq('Cool George')
  end

  it "should NOT have a city" do
    clinic = Clinic.new
    expect(clinic.city).not_to eq('Cool George')
  end

  it "should have a state" do
    expect(subject.state).to eq('SC')
  end

  it "should NOT have a state" do
    clinic = Clinic.new
    expect(clinic.state).not_to eq('SC')
  end

  it "should validate when we have a name" do
    expect(subject.valid?).to eq(true)
  end

  it "should NOT validate when we do not have a name" do
    clinic = Clinic.new
    clinic.save
    expect(clinic.errors).to include(:name)
  end

  it "should have ability to add doctors" do
    subject.doctors << doctor
    expect(subject.doctors.length).to eq(1)
  end

  it "should have ability to add patient" do
    subject.patients << patient
    expect(subject.patients.length).to eq(1)
  end

  it {should have_many(:patients)}

  it {should have_many(:doctors)}
  
end


    # t.string   "name",       limit: 255
    # t.string   "st_address", limit: 255
    # t.string   "city",       limit: 255
    # t.string   "state",      limit: 255