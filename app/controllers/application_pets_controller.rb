class ApplicationPetsController < ApplicationController
  def create
    ApplicationPet.create!(pet_id: params[:pet], application_id: params[:application])
    redirect_to "/applications/#{params[:application]}"
  end
end