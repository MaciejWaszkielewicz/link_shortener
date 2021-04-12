class ShortLink < ApplicationRecord
  belongs_to :user, optional: true

  validates :slug, presence: true, uniqueness: true, format: { with: /\A([a-zA-Z0-9-])+\Z/ }
  validates :url, presence: true, format: { with: /\A((http|https):\/\/|)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/ix }

  def to_param
    slug
  end
end
