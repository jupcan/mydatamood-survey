class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected
  def generate_uuid
    self.id = SecureRandom.uuid unless self.id
  end
end
