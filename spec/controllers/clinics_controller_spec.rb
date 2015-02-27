require 'rails_helper'

describe ClinicsController do
  
  let(:clinic) {
    Clinic.create({ name: 'Clinic1' })
  }


  describe 'GET #index' do
    let!(:clinic1) {
      Clinic.create({ name: "Hello"})
    }
    let!(:clinic2) {
      Clinic.create({ name: "Hi"})
    }
    let!(:clinic3) {
      Clinic.create({ name: "Howdy"})
    }
    it 'should return all clinics' do
      get :index
      expect(assigns(:clinics)).not_to eq(nil)
      expect(assigns(:clinics).length).to eq(3)
      expect(assigns(:clinics)).to include(clinic1)
      expect(assigns(:clinics)).to include(clinic2)
      expect(assigns(:clinics)).to include(clinic3)
    end

    it 'should return all clinics' do
      get :index, q: ""
      expect(assigns(:clinics)).not_to eq(nil)
      expect(assigns(:clinics).length).to eq(3)
      expect(assigns(:clinics)).to include(clinic1)
      expect(assigns(:clinics)).to include(clinic2)
      expect(assigns(:clinics)).to include(clinic3)
    end

    it 'should return all clinics' do
      get :index, q: "H"
      expect(assigns(:clinics)).not_to eq(nil)
      expect(assigns(:clinics).length).to eq(3)
      expect(assigns(:clinics)).to include(clinic1)
      expect(assigns(:clinics)).to include(clinic2)
      expect(assigns(:clinics)).to include(clinic3)
    end

    it 'should not return any clinics' do
      get :index, q: 'asdf'
      expect(assigns(:clinics)).not_to eq(nil)
      expect(assigns(:clinics)).to eq([])
    end

    it 'should return only 1 clinic' do
    get :index, q: 'Hi'
    expect(assigns(:clinics)).not_to eq(nil)
    expect(assigns(:clinics).length).to eq(1)
    expect(assigns(:clinics)).to eq([clinic2])
    end

  end

  describe 'GET #show' do
    let!(:doctor1) {
      Doctor.create({ doctor_name: "Hello", doctorable: clinic})
    }
    let!(:doctor2) {
      Doctor.create({ doctor_name: "Hi", doctorable: clinic})
    }
    let!(:doctor3) {
      Doctor.create({ doctor_name: "Howdy", doctorable: clinic})
    }
    it 'should show a clinic object' do
      get :show, id: clinic
      expect(assigns(:clinic)).to eq clinic
    end

    it 'should show all patient objects under clinic' do
      get :show, id: clinic
      expect(assigns(:patients).length).to eq(0)
      expect(assigns(:patients)).to eq([])
      expect(assigns(:patients).class).to eq(Patient::ActiveRecord_Associations_CollectionProxy)

    end
    it 'should initialize a new doctor object under clinic' do
      get :show, id: clinic
      expect(assigns(:doctor).new_record?).to eq(true)
      expect(assigns(:doctor).class).to eq(Doctor)
    end

    it 'should return all 3 doctor objects' do
      get :show, id: clinic, q: "H"
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors).length).to eq(3)
      expect(assigns(:doctors)).to include(doctor1)
      expect(assigns(:doctors)).to include(doctor2)
      expect(assigns(:doctors)).to include(doctor3)
    end

    it 'should return 1 doctor object' do
      get :show, id: clinic, q2: "Howdy"
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors)).to eq([doctor3])
    end

    it 'should return no doctor objects' do
      get :show, id: clinic, q2: "asdf"
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors)).to eq([])
    end

    it 'should return all doctor objects' do
      get :show, id: clinic
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors).length).to eq(3)
      expect(assigns(:doctors)).to include(doctor1)
      expect(assigns(:doctors)).to include(doctor2)
      expect(assigns(:doctors)).to include(doctor3)
    end

    it 'should return all doctor objects' do
      get :show, id: clinic, q: ""
      expect(assigns(:doctors)).not_to eq(nil)
      expect(assigns(:doctors).length).to eq(3)
      expect(assigns(:doctors)).to include(doctor1)
      expect(assigns(:doctors)).to include(doctor2)
      expect(assigns(:doctors)).to include(doctor3)
    end

  end

  describe 'GET #new' do
    it 'should initialize a new clinic' do
      get :new
      expect(assigns(:clinic).class).to eq Clinic
      expect(assigns(:clinic).new_record?).to eq(true)
    end

  end

  describe 'POST #create' do

    it 'should create a clinic successfully' do
      post :create, clinic: { name: 'Test Clinic' }
      expect(assigns(:clinic).class).to eq(Clinic)
      expect(assigns(:clinic)).not_to be_new_record
      expect(flash[:notice]).to eq('Clinic info was successfully saved.')
      expect(response).to redirect_to clinics_path
    end

    it 'should create a clinic unsuccessfully' do
      post :create, clinic: { name: '' }
      expect(assigns(:clinic).class).to eq(Clinic)
      expect(assigns(:clinic)).to be_new_record
      expect(flash[:alert]).to eq('Clinic info was NOT successfully saved.')
      expect(response).to render_template('new')
    end

  end

  describe 'GET #edit' do

    it 'should show edit for a clinic object' do
      get :edit, id: clinic
      expect(assigns(:clinic)).to eq(clinic)
    end

  end

  describe 'PATCH #update' do

    it 'should assign a clinic id' do
      patch :update, id: clinic, clinic: { name: 'Clinic'}
      expect(assigns(:clinic)).to eq(clinic)
      expect(clinic.name).to eq('Clinic1')
    end

    it 'should update a clinic successfully' do
      patch :update, id: clinic, :clinic=>clinic.attributes = {:name=>"Updated Name"}
      expect(clinic.name).to eq('Updated Name')
      expect(flash[:notice]).to eq('Clinic info successfully updated.')
      expect(response).to redirect_to clinic_path(clinic)
    end

    it 'should update a clinic unsuccessfully' do
      patch :update, id: clinic, clinic:{ name: '' }
      expect(clinic.name).not_to eq('')
      expect(flash[:alert]).to eq('Clinic info was NOT successfully updated.')
      expect(response).to render_template('edit')
    end

  end

  describe 'DELETE #destroy' do
    
    let!(:clinic4) {
      Clinic.create({ name: "Hello"})
    }

    it 'should destroy clinic object' do
     expect{
      delete :destroy, id: clinic4
      }.to change(Clinic, :count).by(-1)
      expect(flash[:notice]).to eq('Clinic was successfully deleted.')
      expect(response).to redirect_to clinics_path
    end

  end


end


