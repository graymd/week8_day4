require 'rails_helper'

describe 'navbar links', type: :feature, js: true do 

  it 'should open about page when click About' do
    visit root_path
    click_link 'About'
    expect(page).to have_content('This is a major hospital tracking system.')
    expect(page).not_to have_content('Go to Clinics Information')
  end

  # it 'should open email browser page when click Contact' do
  #   visit root_path
  #   click_link 'Contact'
  #   expect(page).to have_content('Employee Input')
  # end

  it 'should open root_path when click Home' do
    visit root_path
    click_link 'About'
    expect(page).to have_content('This is a major hospital tracking system.')
    expect(page).not_to have_content('Go to Clinics Information')
    click_link 'Home'
    expect(page).to have_content('Go to Clinics Information')
    expect(page).not_to have_content('This is a major hospital tracking system.')
  end

  it 'should open drop down when click Navigate' do
    visit root_path
    expect(page).not_to have_content('Clinics Main')
    expect(page).not_to have_content('Medications Main')
    find(".dropdown").click
    expect(page).to have_content('Clinics Main')
    expect(page).to have_content('Medications Main')
  end

end