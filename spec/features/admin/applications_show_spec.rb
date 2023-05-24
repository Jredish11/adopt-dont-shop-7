require 'rails_helper'

RSpec.describe 'admin/applications/:id', type: :feature do
  describe 'as a visitor, when I visit an admin application show page' do
    let!(:shelter_1) { Shelter.create!(foster_program: true, name:"Soul Dog Rescue", city:"Ft Lupton", rank:1)}
    let!(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Frankenstein")}
    let!(:app_1) { Application.create!(name: "Max Power", street_address: "456 Main St", city: "Broomfield", state: "CO", zip_code: 80211, description: "Love animals", status: "in progress") }
    let!(:app_2) { Application.create!(name: "Clark Kent", street_address: "93428 Washington Ave", city: "Arvada", state: "CO", zip_code: 80411, description: "Family loves animals", status: "pending") }
    let!(:application_pets_1) { ApplicationPet.create!(application_id: app_1.id, pet_id: pet_1.id) }
    let!(:application_pets_2) { ApplicationPet.create!(application_id: app_2.id, pet_id: pet_1.id) }
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
      visit "/admin/applications/#{app_1.id}"
      click_button("Approve")
      # save_and_open_page
      app_1.reload

      expect(page).to have_content("Approved")
      expect(page).to_not have_button("Approve")
    end
  
    #13. Rejecting a Pet for Adoption
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    # For every pet that the application is for, I see a button to reject the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I rejected, I do not see a button to approve or reject this pet
    # And instead I see an indicator next to the pet that they have been rejected
  
    it 'displays a button to reject the application for a specific pet' do
      visit "/admin/applications/#{app_1.id}"
      # save_and_open_page
      expect(page).to have_button("Reject")    
    end
  
    it 'then returns me to admin/applications/:id and that pet can not be rejected or approved again' do
      visit "/admin/applications/#{app_1.id}"
      click_button("Reject")

      app_1.reload
    
      expect(page).to have_content("Rejected")
      expect(page).to_not have_button("Approve")
      expect(page).to_not have_button("Reject")
    end
  
    # 14. Approved/Rejected Pets on one Application do not affect other Applications

    #   As a visitor
    #   When there are two applications in the system for the same pet
    #   When I visit the admin application show page for one of the applications
    #   And I approve or reject the pet for that application
    #   When I visit the other application's admin show page
    #   Then I do not see that the pet has been accepted or rejected for that application
    #   And instead I see buttons to approve or reject the pet for this specific application
  
    it 'only shows accept or reject on another application' do
      visit "/admin/applications/#{app_1.id}"
      click_button("Approve")

      app_1.reload
    
      visit "/admin/applications/#{app_2.id}"
      save_and_open_page
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
      expect(page).to_not have_content("Approved")
      expect(page).to_not have_content("Rejected")
    end
  end
end
