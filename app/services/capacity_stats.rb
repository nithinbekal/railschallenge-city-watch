class CapacityStats
  def as_json(_options)
    Responder.types
      .map { |type| [type, stats_for(type)] }.to_h
  end

  private

  def stats_for(type)
    [
      total_capacity(type),
      available_capacity(type),
      on_duty_capacity(type),
      available_on_duty_capacity(type)
    ]
  end

  def total_capacity(type)
    Responder.where(type: type).sum(:capacity)
  end

  def available_capacity(type)
    Responder.where(type: type, emergency: nil).sum(:capacity)
  end

  def on_duty_capacity(type)
    Responder.where(type: type, on_duty: true).sum(:capacity)
  end

  def available_on_duty_capacity(type)
    Responder.where(type: type, emergency: nil, on_duty: true).sum(:capacity)
  end
end
