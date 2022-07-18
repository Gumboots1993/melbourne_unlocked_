class Lock < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :visits, dependent: :destroy
  has_one_attached :photo
end
