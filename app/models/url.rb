class Url < ApplicationRecord
  validates :name, presence: true
  VALID_LINK_REGEX = /\A#{URI::regexp(%w(http https))}\z/
  validates :link, presence: true, format: { with: VALID_LINK_REGEX }
end
