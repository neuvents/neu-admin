class Event < ApplicationRecord
  has_many :parties

  validates :title, presence: true
end
