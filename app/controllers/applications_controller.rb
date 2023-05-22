class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @application.status = 'Pending' if params[:commit] == 'Submit Application'
    @pets_search = Pet.search(params[:pet_name].downcase) if params[:pet_name].present?
  end

  def new
  end

  def create
    application = Application.new(application_params)
      if application.valid?
        application.status = "In Progress"
        application.save 
        redirect_to "/applications/#{application.id}"
      else
        flash[:alert] = "Error: #{error_message(application.errors)}"
        redirect_to "/applications/new"
      end
  end

  def update
    application = Application.find(params[:id])
    adopt_pet = Pet.find(params[:pet_id])
    if adopt_pet.nil?
      flash[:alert] = "Error: Pet not found"
    else
      # require 'pry'; binding.pry
      app_pet = ApplicationPet.create!(application_id: application.id, pet_id: adopt_pet.id)
    end

    redirect_to "/applications/#{application.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end