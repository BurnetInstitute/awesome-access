class Role < ActiveRecord::Base

  has_and_belongs_to_many :people


  # Validations
  validates :name, presence: true, uniqueness: true
  validates :identifier, presence: true, uniqueness: true
  validates :description, presence: true

end
