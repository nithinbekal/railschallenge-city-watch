json.responder do
  json.extract! @responder, :emergency_code, :name, :capacity, :type
  json.set! :on_duty, @responder.on_duty?
end
