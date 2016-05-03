json.responders @responders do |r|
  json.extract! r, :emergency_code, :name, :type, :capacity
  json.set! :on_duty, r.on_duty?
end
