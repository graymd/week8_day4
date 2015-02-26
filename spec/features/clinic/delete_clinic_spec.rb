require 'rails_helper'

# DatabaseCleaner.strategy = :truncation
# DatabaseCleaner.clean
# FactoryGirl.create(:clinic)

describe 'test the delete clinic' do 

    before(:each) do
     FactoryGirl.create(:clinic)
    end

  it 'should delete the clinic when clicked' do
    
    visit clinics_path
    expect(page).to have_content('New Clinic Hospital')
    click_link 'New Clinic Hospital'
    expect(page).to have_content('Edit Clinic')
    click_link "Delete Clinic"
    expect(page).to have_content('Clinic was successfully deleted.')
    expect(page).not_to have_content('New Clinic Hospital')
  end
  
end