require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end
  
  before(:each) do
    shelter_1 = Shelter.create!(foster_program: true, name: "Soul Dog Rescue", city: "Ft Lupton", rank: 1)
    pet_1 = shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Frankenstein")
    app_1 = Application.create!(name: "Max Power", street_address: "456 Main St", city: "Broomfield", state: "CO", zip_code: 80211, description: "Love animals", status: "in progress")
    application_pets_1 = ApplicationPet.create!(application_id: app_1.id, pet_id: pet_1.id)
  end

  describe "class methods" do
    describe "#approve!" do
      it "approves pet applications" do
        application_pet = ApplicationPet.first
        application_pet.approve!
        expect(application_pet.status).to eq("Approved")
      end
    end

    describe "#reject!" do
      it "rejects pet applications" do
        application_pet = ApplicationPet.first
        application_pet.reject!
        expect(application_pet.status).to eq("Rejected")
      end
    end
  end
end
