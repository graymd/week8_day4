require 'rails_helper'

RSpec.describe PatientMedication, type: :model  do
  
  it {should belong_to(:patient)}

  it {should belong_to(:medication)}

end