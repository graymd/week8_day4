module PatientsHelper

  def workflow_state_helper(patient)
    if patient.current_state == "waiting_room"
      "Patient is in waiting room."
    elsif patient.workflow_state == "doctor_checkup"
      "Patient is with the doctor."
    elsif patient.workflow_state == "xray"
      "Patient is in xray."
    elsif patient.workflow_state == "surgery"
      "Patient is in surgery."
    elsif patient.workflow_state == "pay_bill"
      "Patient is paying bill."
    elsif patient.workflow_state == "left"
      "Patient has left."
    end
  end

  def patient_state_links(patient, clinic)
    patient_state_links_array = []
    waiting_room_links = [
      (link_to "To Doctor", 'javascript:void(0);', class: 'to-doctor', patient_id: patient.id, clinic_id: clinic.id),
      (link_to "To X-ray", 'javascript:void(0);', class: 'to-xray', patient_id: patient.id, clinic_id: clinic.id),
      (link_to "To Surgery", 'javascript:void(0);', class: 'to-surgery', patient_id: patient.id, clinic_id: clinic.id),
      (link_to "Leave", 'javascript:void(0);', class: 'leave', patient_id: patient.id, clinic_id: clinic.id)
    ]
    doctor_checkup_links = [
      (link_to "To X-ray", 'javascript:void(0);', class: 'to-xray', patient_id: patient.id, clinic_id: clinic.id),
      (link_to "To Surgery", 'javascript:void(0);', class: 'to-surgery', patient_id: patient.id, clinic_id: clinic.id),
      (link_to "To Pay Bill", 'javscript:void(0);', class: 'to-pay-bill', patient_id: patient.id, clinic_id: clinic.id)
    ]
    xray_links = [
      (link_to "To Doctor", 'javscript:void(0);', class: 'to-doctor', patient_id: patient.id, clinic_id: clinic.id),
      (link_to "To Surgery", 'javascript:void(0);', class: 'to-surgery', patient_id: patient.id, clinic_id: clinic.id),
      (link_to "To Pay Bill", 'javscript:void(0);', class: 'to-pay-bill', patient_id: patient.id, clinic_id: clinic.id)
    ]
    surgery_links = [
      (link_to "To Doctor", 'javscript:void(0);', class: 'to-doctor', patient_id: patient.id, clinic_id: clinic.id),
      (link_to "To X-ray", 'javascript:void(0);', class: 'to-xray', patient_id: patient.id, clinic_id: clinic.id),
      (link_to "To Pay Bill", 'javscript:void(0);', class: 'to-pay-bill', patient_id: patient.id, clinic_id: clinic.id)
    ]
    pay_bill_links = [
      (link_to "Leave", 'javascript:void(0);', class: 'to-leave', patient_id: patient.id, clinic_id: clinic.id)
    ]
    left_links = [
      (link_to "Back in to Waiting Room", 'javascript:void(0);', class: 'to-waiting-room', patient_id: patient.id, clinic_id: clinic.id)
    ]
    if patient.waiting_room?
      patient_state_links_array.push(waiting_room_links)
      return patient_state_links_array.join(' | ').html_safe
    elsif patient.doctor_checkup?
      patient_state_links_array.push(doctor_checkup_links)
      return patient_state_links_array.join(' | ').html_safe
    elsif patient.xray?
      patient_state_links_array.push(xray_links)
      return patient_state_links_array.join(' | ').html_safe
    elsif patient.surgery?
      patient_state_links_array.push(surgery_links)
      return patient_state_links_array.join(' | ').html_safe
    elsif patient.pay_bill?
      patient_state_links_array.push(pay_bill_links)
      return patient_state_links_array.join(' | ').html_safe
    elsif patient.left?
      patient_state_links_array.push(left_links)
      return patient_state_links_array.join(' | ').html_safe
    end
  end
end