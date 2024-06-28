class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by,
    against: [:name, :details, :category],
    using: {
      tsearch: { prefix: true }
    }
end
