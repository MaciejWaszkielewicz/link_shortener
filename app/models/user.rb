# frozen_string_literal: true

class User < ActiveRecord::Base

  has_many :short_links

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable,
  # :recoverable

  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
end
