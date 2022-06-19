# frozen_string_literal: true

class Beer < ApplicationRecord
  validates :name, :description, :image_url, presence: true, uniqueness: true
end
