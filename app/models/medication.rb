class Medication < ActiveRecord::Base
  has_many :patient_medications
  has_many :patients, through: :patient_medications

  validates :name, presence: true


  def has_generic?
    if self.generic_option == true
      "yes"
    else
      "no"
    end
  end


end
