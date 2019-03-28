class Mmo < ApplicationRecord
  belongs_to :partner

  validates_presence_of :name, :start_date, :end_date
end
