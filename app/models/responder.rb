class Responder < ActiveRecord::Base
  self.inheritance_column = :_type

  validates :capacity, presence: true, inclusion: 1..5
  validates :name, presence: true, uniqueness: true
  validates :type, presence: true

  belongs_to :emergency

  scope :available, -> { where(on_duty: true, emergency: nil) }

  def self.types
    %w(Fire Medical Police)
  end
end
