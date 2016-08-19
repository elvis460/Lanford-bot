class Product < ApplicationRecord
  has_many :product_buttons
  belongs_to :action
end
