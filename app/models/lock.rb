class Lock < ApplicationRecord
  # before_action :admin_user, only: [:create]

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :visits, dependent: :destroy
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_all,
    against: [ :address, :description, :lock_type, :name ],
    using: {
      tsearch: { prefix: true }
    }
end
