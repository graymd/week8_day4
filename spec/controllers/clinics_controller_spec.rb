require 'rails_helper'

describe ClinicsController do






end







  # def index
  #   @clinics = if !params[:q].blank?
  #     (Clinic.where("name LIKE ? OR st_address LIKE ? OR city LIKE ? OR state LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")).reverse

  #   else
  #   @clinics = (Clinic.all).reverse

  #   end