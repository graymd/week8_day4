require 'rails_helper'

describe 'test the add a new clinic', type: :feature, js: true do
  it 'should add a new clinic successfully' do
    visit clinics_path
    expect(page).to have_content('Add New Clinic')
    click_link 'Add New Clinic'
    expect(page).to have_content('New Clinic')
    fill_in "Name", with: 'New Clinic'
    fill_in "St address", with: '12345 St'
    fill_in 'City', with: 'Charleston'
    select "South Carolina", :from => "State"
    click_button 'Submit'
    expect(page).to have_content('Clinic info was successfully saved.')
  end

  it 'should not allow clinic submission until name is entered and clicked off field' do
    visit clinics_path
    expect(page).to have_content('Add New Clinic')
    click_link 'Add New Clinic'
    expect(page).to have_content('New Clinic')
    expect(page).to have_button('Submit', disabled: true)
    fill_in "Name", with: 'Another Clinic'
    fill_in "St address", with: ''
    expect(page).to have_button('Submit', disabled: false)
  end

  it 'should show clinic name required until name is entered' do
    visit clinics_path
    expect(page).to have_content('Add New Clinic')
    click_link 'Add New Clinic'
    expect(page).to have_content('New Clinic')
    expect(page).to have_content('Clinic name required')
    fill_in "Name", with: 'Another Clinic'
    expect(page).not_to have_content('Clinic name required')
  end

  it 'should return to clinics index when click cancel' do
    visit clinics_path
    expect(page).to have_content('Add New Clinic')
    click_link 'Add New Clinic'
    expect(page).to have_content('New Clinic')
    click_link 'Cancel'
    expect(page).to have_content('Add New Clinic')
    expect(page).not_to have_content('Cancel')
  end



end





















