require 'rails_helper'

RSpec.describe 'admin/shelters', type: :feature do
  describe 'as a visitor, when I am at the admin shelters index page' do
    let!(:shelter_1) { Shelter.create!(foster_program: true, name:"Soul Dog Rescue", city:"Ft Lupton", rank:1)}
    let!(:shelter_2) { Shelter.create!(foster_program: true, name:"Los Alamos Animal Shelter", city:"Los Alamos", rank:3)}
    let!(:shelter_3) { Shelter.create!(foster_program: false, name:"Humane Society", city:"Portland", rank:5)}
    
    let!(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Frankenstein")}
    let!(:pet_2) { shelter_1.pets.create!(adoptable: true, age: 2, breed: "pitbull", name: "Bruno")}
    let!(:pet_3) { shelter_2.pets.create!(adoptable: true, age: 2, breed: "corgi", name: "Molly")}
    
    let!(:app_1) { Application.create!(name: "Max Power", street_address: "456 Main St", city: "Broomfield", state: "CO", zip_code: 80211, description: "Love animals", status: "in progress") }
    let!(:app_2) { Application.create!(name: "Jane Doe", street_address: "444 8th St", city: "Wheatridge", state: "CO", zip_code: 80231, description: "Outdoorsy, responsible", status: "accepted") }
    
    # ApplicationPet.create!(application: app_2, pet: pet_2)
    # User Story 10 -  SQL Only Story

    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see all Shelters in the system listed in reverse alphabetical order by name
    it 'displays all shelters in reverse alpha order' do
      visit "/admin/shelters"
      # save_and_open_page
      expect(shelter_1.name).to appear_before(shelter_2.name)
      expect(shelter_2.name).to appear_before(shelter_3.name)
    end

    # 11. Shelters with Pending Applications

    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see a section for "Shelters with Pending Applications"
    # And in this section I see the name of every shelter that has a pending application
  
    describe "admin/shelters with pending applications" do
      it 'has a section for shelters with pending applications' do
        ApplicationPet.create!(application: app_2, pet: pet_2)
        visit 'admin/shelters'
        save_and_open_page
        
        expect(page).to have_content('Shelters with Pending Applications')
        expect(page).to have_content(shelter_1.name, count: 2)
      end
    end
  end
end
