class BlogComment < ApplicationRecord

  belongs_to :blogs
  belongs_to :users

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

end
