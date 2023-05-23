class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_by_name_desc
    @pending_apps = Shelter.joins(pets: [{ application_pets: :application }]).where('applications.status' == 'Pending')
  end
end