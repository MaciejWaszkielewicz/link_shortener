class ShortLink < ApplicationRecord
  require 'uri'

  belongs_to :user, optional: true

  before_validation :generate_slug, on: :create, if: proc { |record| record.slug.nil? }

  validates :slug, presence: true, uniqueness: true, format: { with: /\A([a-zA-Z0-9-])+\Z/ }
  validates :url, presence: true, format: { with: URI.regexp([ 'http', 'https' ]) }

  def to_param
    slug
  end

  private

  def generate_slug
    loop do
      self.slug = (0..8).map{['-', *('a'..'z'), *('A'..'Z'), *('0'..'9')].sample}.join
      break unless ShortLink.where(slug: self.slug).exists?
    end
  end
end
