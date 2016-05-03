class Emergency < ActiveRecord::Base
  validates :fire_severity, :police_severity, :medical_severity,
    presence: true,
    numericality: { greater_than_or_equal_to: 0 }

  validates :code, presence: true, uniqueness: true

  has_many :responders

  def full_response?
    Responder.types.all? do |type|
      capacity = responders.where(type: type).sum(:capacity)
      severity = attributes["#{type.downcase}_severity"]
      capacity >= severity
    end
  end
end
