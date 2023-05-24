class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_by_name_desc

    @pending_apps = Shelter.joins(pets: [{ application_pets: :application }]).where('applications.status' == "Pending") end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:commit] == 'Submit Application'
      @application.status = 'Pending' 
      @application.save
    end
  end

  def update
    @app_pet = ApplicationPet.find(params[:app_pet_id])
    @application = Application.find(params[:id])
    if params[:commit] == "Approve"
      @app_pet.approve!
    else
      flash[:alert] = "Error"
    end
    # require 'pry'; binding.pry
    redirect_to "/admin/applications/#{@application.id}"
  end
end

private

def app_pet_params
  params.permit(:approved, :pet_id)
end