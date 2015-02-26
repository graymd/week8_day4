require 'rails_helper'

# DatabaseCleaner.strategy = :truncation
# DatabaseCleaner.clean
# FactoryGirl.create(:clinic)

describe 'test the edit clinic', type: :feature, js: true do

    before(:each) do
     FactoryGirl.create(:clinic)
    end

    it 'should not allow submit until Name has been updated' do
    # FactoryGirl.create(:clinic)
    visit clinics_path
    expect(page).to have_content('New Clinic Hospital')
    click_link 'New Clinic Hospital'
    expect(page).to have_content('Edit Clinic')
    click_link 'Edit Clinic'
    expect(page).to have_content('Edit Clinic Information')
    expect(page).to have_button('Submit', disabled: true)
    fill_in "Name", with: "Updated Clinic"
    expect(page).to have_button('Submit', disabled: true) #need to click off to activate submit button
    fill_in "St address", with: " "
    expect(page).to have_button('Submit', disabled: false)
  end

  it 'should successfully return to Clinic index if click cancel' do
    # FactoryGirl.create(:clinic)
    visit clinics_path
    expect(page).to have_content('New Clinic Hospital')
    click_link 'New Clinic Hospital'
    expect(page).to have_content('Edit Clinic')
    click_link 'Edit Clinic'
    expect(page).to have_content('Edit Clinic Information')
    click_link 'Cancel and Return to Clinic'
    expect(page).to have_content('New Clinic Hospital')
    expect(page).not_to have_content('Cancel and Return to Clinic')
  end

  it 'should successfully edit clinic' do
    # FactoryGirl.create(:clinic)
    visit clinics_path
    expect(page).to have_content('New Clinic Hospital')
    click_link 'New Clinic Hospital'
    expect(page).to have_content('Edit Clinic')
    click_link 'Edit Clinic'
    expect(page).to have_content('Edit Clinic Information')
    fill_in "Name", with: "Updated Clinic Name"
    fill_in "St address", with: "Updated Street"
    fill_in "City", with: "Updated City"
    select "North Carolina", :from => "State"
    click_button "Submit"
    expect(page).to have_content('Clinic info successfully updated.')
    expect(page).to have_content('Updated Clinic Name')
    expect(page).to have_content('Updated Street')
    expect(page).to have_content('Updated City')
    expect(page).to have_content('NC')
  end
  
end