class Project < ApplicationRecord
  has_many :reviews
  belongs_to :client
  accepts_nested_attributes_for :reviews
end
