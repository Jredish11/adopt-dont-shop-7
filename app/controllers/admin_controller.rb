class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_by_name_desc
  end
end