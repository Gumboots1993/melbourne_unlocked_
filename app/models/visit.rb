class Visit < ApplicationRecord
  belongs_to :user
  belongs_to :lock
end
