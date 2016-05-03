class Responder < ActiveRecord::Base
  self.inheritance_column = :_type

  validates :capacity, presence: true, inclusion: 1..5
  validates :name, presence: true, uniqueness: true
  validates :type, presence: true
end
