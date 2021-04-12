class ShortLink < ApplicationRecord
  belongs_to :user, optional: true

  validates :slug, presence: true, format: { with: /\A([a-zA-Z0-9-])+\Z/ }

  def to_param
    slug
  end
end
