class PatientsController < ApplicationController
  before_action :set_patient, only: [
    :show,
    :edit,
    :update,
    :destroy,
    :wait_patient
  ]

  def index
    set_clinic
    @patients = if !params[:q].blank?
      @clinic.patients.where("first_name LIKE ? OR last_name LIKE ? OR date_of_birth LIKE ? OR description LIKE ? OR gender LIKE ? OR blood_type LIKE ? OR workflow_state LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    else
      @clinic.patients
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
   @clinic = Clinic.find params[:clinic_id]
   @patient = Patient.find params[:id]
   @medications = @patient.medications
   @doctor = Doctor.new
   @doctors = if !params[:q].blank?
    @patient.doctors.where("doctor_name LIKE ?", "%#{params[:q]}%")
   else
    @patient.doctors
    end
  end


  def new
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.new
    @medications = Medication.all
  end

  def create
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.create patient_params
    @medications = Medication.all
    if @patient.save
      flash[:notice] = 'Patient info was successfully saved.'
      redirect_to clinic_path(@clinic)
    else
      flash[:alert] = 'Patient info was NOT successfully saved.'
      render :new
    end
  end

  def edit
    @clinic = Clinic.find params[:clinic_id]
    @medications = Medication.all
    @patient = @clinic.patients.find params[:id]
  end

  def update
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:id]
    @medications = Medication.all
    if @patient.update_attributes patient_params
      flash[:notice] = 'Patient info was successfully updated.'
      redirect_to clinic_path(@clinic)
    else
      flash[:alert] = 'Patient info was NOT successfully updated.'
      render :edit
    end
  end

  def destroy
    @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
    if @patient.destroy
      flash[:notice] = 'Patient info was successfully deleted.'
      redirect_to clinic_path(@clinic)
    else
      flash[:alert] = 'Patient info was NOT successfully deleted.'
    end
  end

  def create_doctor
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:id] 
    @doctor = @patient.doctors.create doctor_params
    redirect_to clinic_patient_path(@clinic, @patient)
  end

  def destroy_doctor
    @doctor = Doctor.find params[:id]
    @doctor.destroy
    redirect_to clinic_patient_path(@doctor.doctorable.clinic, @doctor.doctorable)
  end

  def wait_patient
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:id]
    @patient.wait!
    respond_to do |format|
      format.js
    end
  end

  def to_doctor_patient
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:id]
    @patient.to_doctor!
    respond_to do |format|
      format.js
    end
  end

  def to_xray_patient
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:id]
    @patient.to_xray!
    respond_to do |format|
      format.js
    end
  end

  def to_surgery_patient
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:id]
    @patient.to_surgery!
    respond_to do |format|
      format.js
    end
  end

  def to_pay_bill_patient
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:id]
    @patient.to_pay_bill!
    respond_to do |format|
      format.js
    end
  end

  def leave_patient
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:id]
    @patient.leave!
    respond_to do |format|
      format.js
    end
  end

  def search
    @clinic = Clinic.find params[:clinic_id]
    if !params[:q].blank? 
      @patients = @clinic.patients.where("first_name LIKE ? OR last_name LIKE ? OR date_of_birth LIKE ? OR description LIKE ? OR gender LIKE ? OR blood_type LIKE ? OR workflow_state LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    else
      @patients = @clinic.patients
    end
    respond_to do |format|
      format.js
      format.html
    end
    puts params[:_]
  end

private
  def patient_params
    params.require(:patient).permit(
        :first_name,
        :last_name,
        :date_of_birth,
        :description,
        :gender,
        :blood_type,
        medication_ids: []
      ) 
  end

  def set_clinic
    @clinic = Clinic.find(params[:clinic_id])
  end

  def set_patient
    @patient = Patient.find params[:id]
  end

  def doctor_params
  params.require(:doctor).permit(
    :doctor_name
    )
  end

end
