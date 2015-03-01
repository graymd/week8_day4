require 'rails_helper'

describe PatientsController do 

let!(:patient) { FactoryGirl.create(:patient) }

  describe 'GET #index' do

    it 'should set a clinic' do
    get :index, clinic_id: patient.clinic_id
    expect(assigns(:clinic).id).to eq(patient.clinic_id)
    end

    it 'should return all patients' do
      get :index, clinic_id: patient.clinic_id
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients).length).to eq(1)
    end

    it 'should return all patients' do
      get :index, clinic_id: patient.clinic_id, q: ''
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients).length).to eq(1)
    end

    it 'should return no patients' do
      get :index, clinic_id: patient.clinic_id, q: 'asdf'
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients).length).to eq(0)
      expect(assigns(:patients)).to eq([])
    end

    it 'should return all patients' do

      get :index, clinic_id: patient.clinic_id, q: 'Maddie'
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients).length).to eq(1)
    end

  end

  describe 'GET #show' do

    let!(:doctor1) {
      Doctor.create({ doctor_name: "Hello", doctorable: patient})
    }
    let!(:doctor2) {
      Doctor.create({ doctor_name: "Hi", doctorable: patient})
    }
    let!(:doctor3) {
      Doctor.create({ doctor_name: "Howdy", doctorable: patient})
    }

    it 'should set a clinic id' do
      get :show, clinic_id: patient.clinic_id, id: patient
      expect(assigns(:clinic).id).to eq(patient.clinic_id)
    end

    it 'should show a patient object' do
      get :show, clinic_id: patient.clinic_id, id: patient
      expect(assigns(:patient)).to eq(patient)
    end

    it 'should show all medication objects under the patient' do
      get :show, clinic_id: patient.clinic_id, id: patient
      expect(assigns(:medications).length).to eq(0)
      expect(assigns(:medications)).to eq([])
      expect(assigns(:medications).class).to eq(Medication::ActiveRecord_Associations_CollectionProxy)
    end

    it 'should initialize a new doctor object under patient' do
      get :show, clinic_id: patient.clinic_id, id: patient
      expect(assigns(:doctor).new_record?).to eq(true)
      expect(assigns(:doctor).class).to eq(Doctor)
    end

    it 'should return all 3 doctor objects' do
      get :show, clinic_id: patient.clinic_id, id: patient, q: "H"
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors).length).to eq(3)
      expect(assigns(:doctors)).to include(doctor1)
      expect(assigns(:doctors)).to include(doctor2)
      expect(assigns(:doctors)).to include(doctor3)
    end

    it 'should return all 3 doctor objects' do
      get :show, clinic_id: patient.clinic_id, id: patient, q: ""
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors).length).to eq(3)
      expect(assigns(:doctors)).to include(doctor1)
      expect(assigns(:doctors)).to include(doctor2)
      expect(assigns(:doctors)).to include(doctor3)
    end

    it 'should return 1 doctor object' do
      get :show, clinic_id: patient.clinic_id, id: patient, q: "Hello"
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors).length).to eq(1)
      expect(assigns(:doctors)).to include(doctor1)
    end

    it 'should return no doctor object' do
      get :show, clinic_id: patient.clinic_id, id: patient, q: "asdf"
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors).length).to eq(0)
      expect(assigns(:doctors)).not_to include(doctor1)
      expect(assigns(:doctors)).not_to  include(doctor2)
      expect(assigns(:doctors)).not_to include(doctor3)
    end

    it 'should return all 3 doctor objects' do
      get :show, clinic_id: patient.clinic_id, id: patient
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors).length).to eq(3)
      expect(assigns(:doctors)).to include(doctor1)
      expect(assigns(:doctors)).to include(doctor2)
      expect(assigns(:doctors)).to include(doctor3)
    end

  end

  describe 'GET #new' do

    it 'should initialize a new patient' do
      get :new, clinic_id: patient.clinic_id
      expect(assigns(:patient).class).to eq(Patient)
      expect(assigns(:patient).new_record?).to eq(true)
    end

  end

  describe 'POST #create' do

    it 'should set a clinic id' do
      post :create, clinic_id: patient.clinic_id, patient: {  
        first_name: 'Maddie',
        last_name: 'Of the May',
        date_of_birth: 12.years.ago,
        description: 'Sick of not getting lots of food',
        gender: 'female',
        blood_type: 'O-'
      }
      expect(assigns(:clinic).id).to eq(patient.clinic_id)
    end

    it 'should create a patient successfully' do
      post :create, clinic_id: patient.clinic_id, patient: {  
        first_name: 'Maddie',
        last_name: 'Of the May',
        date_of_birth: 12.years.ago,
        description: 'Sick of not getting lots of food',
        gender: 'female',
        blood_type: 'O-'
      }
      expect(assigns(:patient).class).to eq(Patient)
      expect(assigns(:patient)).not_to be_new_record
      expect(flash[:notice]).to eq('Patient info was successfully saved.')
      expect(response).to redirect_to clinic_path(patient.clinic)
    end

    it 'should create a patient unsuccessfully' do
      post :create, clinic_id: patient.clinic_id, patient: {  
        first_name: '',
        last_name: '',
        date_of_birth: '',
        description: '',
        gender: '',
        blood_type: ''
      }
      expect(assigns(:patient).class).to eq(Patient)
      expect(assigns(:patient)).to be_new_record
      expect(flash[:alert]).to eq('Patient info was NOT successfully saved.')
      expect(response).to render_template('new')
    end

  end

  describe 'GET #edit' do

    it 'should set a clinic id' do
      get :edit, clinic_id: patient.clinic_id, id: patient
      expect(assigns(:clinic).id).to eq(patient.clinic_id)
    end

    it 'should set all medications' do
      get :edit, clinic_id: patient.clinic_id, id: patient
      expect(assigns(:medications).length).to eq(0)
      expect(assigns(:medications).class).to eq(Medication::ActiveRecord_Relation)
      expect(assigns(:medications)).to eq([])
    end

    it 'should set a patient id' do
      get :edit, clinic_id: patient.clinic_id, id: patient
      expect(assigns(:patient)).to eq(patient)
    end

  end

  describe 'PATCH #udpate' do

    it 'should set clinic id' do
      patch :update, clinic_id: patient.clinic_id, id: patient, patient: {  
        first_name: 'Maddie',
        last_name: 'Of the May',
        date_of_birth: 12.years.ago,
        description: 'Sick of not getting lots of food',
        gender: 'female',
        blood_type: 'O-'
      }
      expect(assigns(:clinic).id).to eq(patient.clinic_id)
    end

    it 'should set patient' do
      patch :update, clinic_id: patient.clinic_id, id: patient, patient: {  
        first_name: 'Maddie',
        last_name: 'Of the May',
        date_of_birth: 12.years.ago,
        description: 'Sick of not getting lots of food',
        gender: 'female',
        blood_type: 'O-'
      }
      expect(assigns(:patient)).to eq(patient)
    end

    it 'should set all medications' do
      patch :update, clinic_id: patient.clinic_id, id: patient, patient: {  
        first_name: 'Maddie',
        last_name: 'Of the May',
        date_of_birth: 12.years.ago,
        description: 'Sick of not getting lots of food',
        gender: 'female',
        blood_type: 'O-'
      }
      expect(assigns(:medications).length).to eq(0)
      expect(assigns(:medications).class).to eq(Medication::ActiveRecord_Relation)
      expect(assigns(:medications)).to eq([])
    end

    it 'should update a patient successfully' do
      patch :update, clinic_id: patient.clinic_id, id: patient, :patient=>patient.attributes = {  
        :first_name=> 'Madison',
        :last_name=> 'Of the May',
        :date_of_birth=> 12.years.ago,
        :description=> 'Sick of not getting lots of food',
        :gender=> 'female',
        :blood_type=> 'O-'
      }
      expect(patient.first_name).to eq('Madison')
      expect(flash[:notice]).to eq('Patient info was successfully updated.')
      expect(response).to redirect_to clinic_path(patient.clinic_id)
    end

      it 'should update a patient unsuccessfully' do
      patch :update, clinic_id: patient.clinic_id, id: patient, patient:{ first_name: ''}
      expect(patient.first_name).not_to eq('')
      expect(flash[:alert]).to eq('Patient info was NOT successfully updated.')
      expect(response).to render_template('edit')
    end

  end

  describe 'DELETE #destroy' do

    it 'should destroy patient object' do
      expect{
        delete :destroy, clinic_id: patient.clinic_id, id: patient}.to change(Patient, :count).by(-1)
      expect(flash[:notice]).to eq('Patient info was successfully deleted.')
      expect(response).to redirect_to clinic_path(patient.clinic_id)
    end

  end

  describe 'POST #create_doctor' do

    it 'should create a doctor object' do
      post :create_doctor, clinic_id: patient.clinic_id, id: patient, doctor: { doctor_name: 'Maddiest', doctorable: patient }
      expect(assigns(:clinic).id).to eq(patient.clinic_id)
      expect(assigns(:doctor).class).to eq(Doctor)
      expect(assigns(:doctor).doctorable_id).to eq(patient.id)
      expect(assigns(:doctor).doctorable_type).to eq('Patient')
      expect(response).to redirect_to clinic_patient_path(patient.clinic_id, patient)
    end

  end

  describe 'DELETE #destroy_doctor' do

    let!(:doctor4) {
      Doctor.create({ doctor_name: "Maddiest", doctorable: patient })
    }

    it 'should delete doctor object' do
      expect{
        delete :destroy_doctor, clinic_id: patient.clinic_id, id: doctor4
      }.to change(Doctor, :count).by(-1)
      expect(response).to redirect_to clinic_patient_path(doctor4.doctorable.clinic, doctor4.doctorable)
    end

  end

  describe 'PATCH #wait_patient' do

    let!(:patient1){FactoryGirl.create(:patient, workflow_state: 'left')}

    it 'should set patient workflow to waiting_room' do
      patch :wait_patient, clinic_id: patient1.clinic_id, id: patient1, format: :js
      expect(assigns(:clinic).id).to eq(patient1.clinic_id)
      expect(assigns(:patient)).to eq(patient1)
      expect(assigns(:patient).current_state).to eq('waiting_room')
    end

  end

  describe 'PATCH #to_doctor_patient' do

    it 'should set patient workflow to doctor_checkup' do
      patch :to_doctor_patient, clinic_id: patient.clinic_id, id: patient, format: :js
      expect(assigns(:clinic).id).to eq(patient.clinic_id)
      expect(assigns(:patient)).to eq(patient)
      expect(assigns(:patient).current_state).to eq('doctor_checkup')
    end

  end

  describe 'PATCH #to_xray_patient' do

    it 'should set patient workflow to xray' do
      patch :to_xray_patient, clinic_id: patient.clinic_id, id: patient, format: :js
      expect(assigns(:clinic).id).to eq(patient.clinic_id)
      expect(assigns(:patient)).to eq(patient)
      expect(assigns(:patient).current_state).to eq('xray')
    end

  end
  
  describe 'PATCH #to_surgery_patient' do

    it 'should set patient workflow to surgery' do
      patch :to_surgery_patient, clinic_id: patient.clinic_id, id: patient, format: :js
      expect(assigns(:clinic).id).to eq(patient.clinic_id)
      expect(assigns(:patient)).to eq(patient)
      expect(assigns(:patient).current_state).to eq('surgery')
    end

  end


  describe 'PATCH #to_pay_bill_patient' do

    let!(:patient1){FactoryGirl.create(:patient, workflow_state: 'doctor_checkup')}

    it 'should set patient workflow to pay_bill' do
      patch :to_pay_bill_patient, clinic_id: patient1.clinic_id, id: patient1, format: :js
    expect(assigns(:clinic).id).to eq(patient1.clinic_id)
      expect(assigns(:patient)).to eq(patient1)
      expect(assigns(:patient).current_state).to eq('pay_bill')
    end

  end

  describe 'PATCH #leave_patient' do

    let!(:patient1){FactoryGirl.create(:patient, workflow_state: 'pay_bill')}

    it 'should set patient workflow to left' do
      patch :leave_patient, clinic_id: patient1.clinic_id, id: patient1, format: :js
      expect(assigns(:clinic).id).to eq(patient1.clinic_id)
      expect(assigns(:patient)).to eq(patient1)
      expect(assigns(:patient).current_state).to eq('left')
    end

  end

  describe 'GET #search' do

    it 'should set clinic id' do
      xhr :get, :search, clinic_id: patient.clinic_id, id: patient, format: :js
      expect(assigns(:clinic).id).to eq(patient.clinic_id)
    end

    it 'should return all patients' do
      xhr :get, :search, clinic_id: patient.clinic_id
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients).length).to eq(1)
    end

    it 'should return all patients' do
      xhr :get, :search, clinic_id: patient.clinic_id, q: ''
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients).length).to eq(1)
    end

    it 'should return no patients' do
      xhr :get, :search, clinic_id: patient.clinic_id, q: 'asdf'
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients).length).to eq(0)
      expect(assigns(:patients)).to eq([])
    end

    it 'should return all patients' do

      xhr :get, :search, clinic_id: patient.clinic_id, q: 'Maddie'
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients).length).to eq(1)
    end

  end






end






 