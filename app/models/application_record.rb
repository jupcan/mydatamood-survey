# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected

  def generate_uuid
    self.id = SecureRandom.uuid unless id
  end
end

