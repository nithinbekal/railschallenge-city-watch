class DispatchResponders
  def initialize(emergency)
    @emergency = emergency
  end

  def call
    dispatch_responders 'Fire',    emergency.fire_severity
    dispatch_responders 'Medical', emergency.medical_severity
    dispatch_responders 'Police',  emergency.police_severity
  end

  private

  attr_reader :emergency

  def dispatch_responders(type, severity)
    return if severity <= 0

    dispatch_single_matching_responder(type, severity) ||
    dispatch_multiple_responders(type, severity)
  end

  def dispatch_single_matching_responder(type, severity)
    if responder = available_responders.find_by(type: type, capacity: severity)
      assign_responder(responder)
      return true
    end

    false
  end

  def dispatch_multiple_responders(type, severity)
    responders = available_responders.where(type: type).order(capacity: :desc)

    responders.each do |r|
      assign_responder(r)
      severity -= r.capacity
      return true if severity <= 0
    end

    false
  end

  def assign_responder(responder)
    emergency.responders << responder
  end

  def available_responders
    Responder.available
  end
end
