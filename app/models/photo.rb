class Photo < ApplicationRecord
  belongs_to :gallery
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [240, 160]
    attachable.variant :main, resize_to_limit: [1200, 800]
  end
end
