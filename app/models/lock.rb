class Lock < ApplicationRecord
  has_many :visits, dependent: :destroy
end
