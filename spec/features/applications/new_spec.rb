require 'rails_helper'

RSpec.describe "/applications/new" do
      # User Story 2. Starting an Application

      # As a visitor
      # Then I am taken to the new application page where I see a form
      # When I fill in this form with my:
      #   - Name
      #   - Street Address
      #   - City
      #   - State
      #   - Zip Code
      #   - Description of why I would make a good home
      # And I click submit
      # Then I am taken to the new application's show page
      # And I see my Name, address information, and description of why I would make a good home
      # And I see an indicator that this application is "In Progress"
      # start at pet index page => link to start an application
      # link directs to new application page => form to fill out new application
      # submit to new applications show page that was just created
      # status is #inprogress
  describe 'as a visitor, I start a new application' do
    it 'has a form with all required params' do
      visit "/applications/new"
      expect(current_path).to eq "/applications/new"
      expect(page).to have_content("Name")
      expect(page).to have_content("Street address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip code")
      expect(page).to have_content("Why would you make a good home?")
      expect(page).to have_button("Save")
      expect(page).to have_no_content("In Progress")
    end

    it 'saves when completed and redirects to show page' do
      visit "/applications/new"

      fill_in "Name", with: "Colin"
      fill_in "Street address", with: "245 33rd St"
      fill_in "City", with: "Los Alamos"
      fill_in "State", with: "NM"
      fill_in "Zip code", with: 87502
      fill_in :description, with: "I am awesome"
      click_button "Save"

  
      expect(page).to have_content("Colin")
      expect(page).to have_content("245 33rd St")
      expect(page).to have_content("Los Alamos")
      expect(page).to have_content("NM")
      expect(page).to have_content("87502")
      expect(page).to have_content("I am awesome")
      expect(page).to have_content("In Progress")
    end

    describe "when form fields are incomplete" do
      it 'displays error message and takes visitor back to new applications page' do
      visit "/applications/new"

      click_button "Save"


      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Description can't be blank\nPets\nShelters\nVeterinarians\nVeterinary Offices\nNew Application\nName\nStreet address\nCity\nState\nZip code\nWhy would you make a good home?")
      end
    end
  end
end    