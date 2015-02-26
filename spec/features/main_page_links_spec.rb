require 'rails_helper'

describe 'test the links on the main page' do
  it 'should open clinics index page when clicking Go to Clinics Information link' do
    visit root_path
    expect(page).to have_content("Go to Clinics Information")
    click_link('Go to Clinics Information')
    expect(page).to have_content('Add New Clinic')
    expect(page).not_to have_content('Go to Clinics Information')
  end

  it 'should open medication index page when clicking Go to Medication Information link' do
    visit root_path
    expect(page).to have_content('Go to Medication Information')
    click_link('Go to Medication Information')
    expect(page).to have_content('Add New Medication')
    expect(page).not_to have_content('Go to Medication Information')
  end

end
