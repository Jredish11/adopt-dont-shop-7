class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approve!
    self.update(status: "Approved")
  end

  def reject!
    self.update(status: "Rejected")
  end
end