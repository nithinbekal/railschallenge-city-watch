json.emergencies @emergencies do |e|
  json.extract! e, :code, :fire_severity, :police_severity, :medical_severity
end

json.full_responses [1, @emergencies.count]
