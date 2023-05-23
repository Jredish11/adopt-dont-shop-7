class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_by_name_desc
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:commit] == 'Submit Application'
      @application.status = 'Pending' 
      @application.save
    end
  end

  def update
    @application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    if params[:commit] == "Approve"
      @application.status = 'Approved'
    else
      flash[:alert] = "Error"
    end
    @application.save

    redirect_to "/admin/applications/#{@application.id}"
  end
end