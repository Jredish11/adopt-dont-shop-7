class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approve!
    self.update(status: "Approved")
  end
end