# frozen_string_literal: true

class User < ApplicationRecord
  after_initialize :generate_uuid
  has_many :interests
end
