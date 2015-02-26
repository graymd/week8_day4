require 'rails_helper'

describe 'test the edit patient', type: :feature, js: true do

  before(:each) do
    FactoryGirl.create(:patient)
  end

  it 'should successfully edit a patient' do
    visit clinics_path
    expect(page).to have_content('New Clinic Hospital')
    click_link "New Clinic Hospital"
    expect(page).to have_content('Maddie')
    #Need to finish adding testing
  end
  
end