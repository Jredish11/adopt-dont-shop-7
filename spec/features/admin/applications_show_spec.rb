require 'rails_helper'

RSpec.describe 'admin/applications/:id', type: :feature do
  describe 'as a visitor, when I visit an admin application show page' do
    let!(:shelter_1) { Shelter.create!(foster_program: true, name:"Soul Dog Rescue", city:"Ft Lupton", rank:1)}
    let!(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Frankenstein")}
    let!(:app_1) { Application.create!(name: "Max Power", street_address: "456 Main St", city: "Broomfield", state: "CO", zip_code: 80211, description: "Love animals", status: "in progress") }
    let!(:application_pets_1) { ApplicationPet.create!(application_id: app_1.id, pet_id: pet_1.id) }

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
        # add approve button in admin/applications show.html.erb 
          # iterate over each pet associated w/ the application
            # each pet, display a button to approve (form_with) => form url to the route for updating 
            # application w/ the pet approval status
              # hidden_field w/ the pet's ID as a parameter
              # submit button "Approve"
      
      expect(page).to have_button("Approve")
    end
    
    it 'takes me back to the admin application show page when I click the button next to Pet,displays indicator next to the pet that I approved, I do not see a button to approve this pet' do
      visit "/admin/applications/#{app_1.id}"
      click_button("Approve")
      # save_and_open_page
      app_1.reload
      expect(page).to have_content("Approved")
      expect(page).to_not have_button("Approve")
    end
  end
end


# 