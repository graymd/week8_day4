require 'rails_helper'

RSpec.describe PatientsHelper, type: :helper do 

  subject do
    Patient.new({
      first_name: "Kitter",
      last_name: "Cat",
      description: "sick",
      gender: "male",
      blood_type: "O-",
      date_of_birth: 10.years.ago
    })
  end

  it "should display Patient is In Waiting Room if patient.current_state == waiting_room" do
    expect(subject.current_state).to eq('waiting_room')
  end

  it "should display Patient is with The Doctor if patient.current_state == doctor_checkup" do
    subject.save!
    subject.to_doctor!
    expect(subject.current_state).to eq('doctor_checkup')
  end

  it "should display Patient is In Xray if patient.current_state == xray" do
    subject.save!
    subject.to_doctor!
    subject.to_xray!
  expect(subject.current_state).to eq('xray')
  end

  it "should display Patient is in Surgery if patient.current_state == surgery" do
    subject.save!
    subject.to_doctor!
    subject.to_surgery!
  expect(subject.current_state).to eq('surgery')
  end

  it "should display Patient is paying bill if patient.current_state == pay_bill" do
    subject.save!
    subject.to_doctor!
    subject.to_pay_bill!
  expect(subject.current_state).to eq('pay_bill')
  end

  it "should display Patient has left if patient.current_state == left" do
    subject.save!
    subject.to_doctor!
    subject.to_pay_bill!
    subject.leave!
  expect(subject.current_state).to eq('left')
  end

  # it ""






























  
end