class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  attribute :approved, :string, default: "Pending"
end