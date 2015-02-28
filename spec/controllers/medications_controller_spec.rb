require 'rails_helper'

describe MedicationsController do 

  let(:medication) {
    Medication.create({ name: "med" })
  }


  describe 'GET #index' do

    let!(:medication1) {
      Medication.create({ name: "med1" })
    }

    let!(:medication2) {
      Medication.create({ name: "med2" })
    }

    let!(:medication3) {
      Medication.create({ name: "med3" })
    }

    it 'should return all medicaitons' do
      get :index, q: 'm'
      expect(assigns(:medications)).not_to eq(nil)
      expect(assigns(:medications).length).to eq(3)
      expect(assigns(:medications)).to include(medication1)
      expect(assigns(:medications)).to include(medication2)
      expect(assigns(:medications)).to include(medication3)
    end

    it 'should return all medicaitons' do
      get :index, q: ''
      expect(assigns(:medications)).not_to eq(nil)
      expect(assigns(:medications).length).to eq(3)
      expect(assigns(:medications)).to include(medication1)
      expect(assigns(:medications)).to include(medication2)
      expect(assigns(:medications)).to include(medication3)
    end

    it 'should not return any medicaitons' do
      get :index, q: 'asdf'
      expect(assigns(:medications)).not_to eq(nil)
      expect(assigns(:medications)).to eq([])
    end

    it 'should return only 1 medication' do
      get :index, q: 'med1'
      expect(assigns(:medications)).not_to eq(nil)
      expect(assigns(:medications).length).to eq(1)
      expect(assigns(:medications)).to eq([medication1])
    end

    it 'should return all medicaitons' do
      get :index
      expect(assigns(:medications)).not_to eq(nil)
      expect(assigns(:medications).length).to eq(3)
      expect(assigns(:medications)).to include(medication1)
      expect(assigns(:medications)).to include(medication2)
      expect(assigns(:medications)).to include(medication3)
    end

  end

  describe 'GET #show' do

    it 'should show a medication object' do
      get :show, id: medication
      expect(assigns(:medication)).to eq(medication)
    end

    it 'should show all patient objects under medication' do
      get :show, id: medication
      expect(assigns(:patients).length).to eq(0)
      expect(assigns(:patients)).to eq([])
      expect(assigns(:patients).class).to eq(Patient::ActiveRecord_Associations_CollectionProxy)
    end

  end

  describe 'GET #new' do

    it 'should initialize a new medicaiton object' do
      get :new
      expect(assigns(:medication).class).to eq(Medication)
      expect(assigns(:medication).new_record?).to eq(true)
    end

  end

  describe 'POST #create' do

    it 'should create a medication object successfully' do
      post :create, medication: { name: 'Post Medication' }
      expect(assigns(:medication).class).to eq(Medication)
      expect(assigns(:medication)).not_to be_new_record
      expect(flash[:notice]).to eq('Medication was successfully saved.')
      expect(response).to redirect_to medications_path
    end

    it 'should create a medication object unsuccessfully' do
      post :create, medication: { name: '' }
      expect(assigns(:medication).class).to eq(Medication)
      expect(assigns(:medication)).to be_new_record
      expect(flash[:alert]).to eq('Medication was NOT successfully saved.')
      expect(response).to render_template('new')
    end

  end

  describe 'GET #edit' do

    it 'should show edit for a medication object' do
      get :edit, id:medication
      expect(assigns(:medication)).to eq(medication)
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients)).to eq([])
    end

  end

  describe 'PATCH #edit' do

    it 'should assign all patient objects' do
      patch :update, id: medication, medication: { name: 'Medication' }
      expect(assigns(:patients)).not_to eq(nil)
      expect(assigns(:patients)).to eq([])
    end
    
    it 'should assign a medication id' do
      patch :update, id: medication, medication: { name: 'Medication' }
      expect(assigns(:medication)).to eq(medication)
    end

    it 'should update a medication successfully' do
      patch :update, id: medication, :medication=>medication.attributes = { :name => 'Updated Medication'}
      expect(medication.name).to eq('Updated Medication')
      expect(flash[:notice]).to eq('Medication was successfully updated.')
      expect(response).to redirect_to medication_path(medication)
    end

    it 'should update a medication unsuccessfully' do
      patch :update, id: medication, medication:{ name: '' }
      expect(medication.name).not_to eq('')
      expect(flash[:alert]).to eq('Medication was NOT successfully updated.')
      expect(response).to render_template('edit')
    end

  end

  describe 'DELETE #destroy' do

    let!(:medication4) {
      Medication.create({ name: "med4" })
    }

    it 'should destroy medication object' do
      expect{
        delete :destroy, id: medication4
      }.to change(Medication, :count).by(-1)
      expect(flash[:notice]).to eq('Medication was successfully deleted.')
      expect(response).to redirect_to medications_path
    end

  end




end
























