require 'rails_helper'

RSpec.describe 'admin/applications/:id', type: :feature do
  describe 'as a visitor, when I visit an admin application show page' do
    let!(:shelter_1) { Shelter.create!(foster_program: true, name:"Soul Dog Rescue", city:"Ft Lupton", rank:1)}
    let!(:shelter_2) { Shelter.create!(foster_program: true, name:"Los Alamos Animal Shelter", city:"Los Alamos", rank:3)}
    let!(:shelter_3) { Shelter.create!(foster_program: false, name:"Humane Society", city:"Portland", rank:5)}
    
    let!(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Frankenstein")}
    let!(:pet_2) { shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Francis")}
    let!(:pet_3) { shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Mr. Francona")}
    
    let!(:app_1) { Application.create!(name: "Max Power", street_address: "456 Main St", city: "Broomfield", state: "CO", zip_code: 80211, description: "Love animals", status: "in progress") }
    let!(:app_2) { Application.create!(name: "Jane Doe", street_address: "444 8th St", city: "Wheatridge", state: "CO", zip_code: 80231, description: "Outdoorsy, responsible", status: "accepted") }

    let!(:app_1) { Application.create!(name: "Max Power", street_address: "456 Main St", city: "Broomfield", state: "CO", zip_code: 80211, description: "Love animals", status: "in progress") }
    let!(:app_2) { Application.create!(name: "Jane Doe", street_address: "444 8th St", city: "Wheatridge", state: "CO", zip_code: 80231, description: "Outdoorsy, responsible", status: "accepted") }
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    # For every pet that the application is for, I see a button to approve the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I approved, I do not see a button to approve this pet
    # And instead I see an indicator next to the pet that they have been approved

    #User Story 12
    it 'displays a button to approve the application next to every pet that the application is for' do
      visit "/admin/applications/#{app_1.id}"

      expect(page).to have_button("Approve")
    end

    it 'takes me back to the admin application show page when I click the button next to Pet,displays indicator next to the pet that I approved, I do not see a button to approve this pet' do
      visit "/admin/applications/#{admin_application.id}"
      click_button("Approve")

      expect(page).to have_content("Approved!")
      expect(page).to_not have_button("Approve")
    end
  end
end
