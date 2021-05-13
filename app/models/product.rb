class Product < ApplicationRecord
  belongs_to :category
  after_initialize :generate_uuid

  protected
  def generate_uuid
    self.id = SecureRandom.uuid unless self.id
  end
end
