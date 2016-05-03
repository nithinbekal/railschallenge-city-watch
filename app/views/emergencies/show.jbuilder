json.emergency do
  json.extract! @emergency, :code, :fire_severity, :police_severity, :medical_severity, :resolved_at
  json.responders @emergency.responders.map(&:name)
  json.full_response @emergency.full_response?
end
