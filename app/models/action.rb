class Action < ApplicationRecord
  has_many :products
  enum action_type: {
      product: 0, #產品
    }
end
