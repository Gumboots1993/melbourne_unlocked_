class Visit < ApplicationRecord
  belongs_to :user
  belongs_to :lock
  has_one_attached :photo
  has_many :reviews, dependent: :destroy
end
