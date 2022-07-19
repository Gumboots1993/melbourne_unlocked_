class Review < ApplicationRecord
  belongs_to :visit

  # validates :rating, presence: true
  # validates :rating, inclusion: [1, 2, 3, 4, 5]
end
