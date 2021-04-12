class ShortLink < ApplicationRecord
  require 'uri'

  belongs_to :user, optional: true

  validates :slug, presence: true, uniqueness: true, format: { with: /\A([a-zA-Z0-9-])+\Z/ }
  validates :url, presence: true, format: { with: URI.regexp(['http', 'https']) }

  def to_param
    slug
  end
end
