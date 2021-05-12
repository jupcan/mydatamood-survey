class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :order_by_score, -> { order(score: :desc) }
  
  protected
  def generate_uuid
    self.id = SecureRandom.uuid unless self.id
  end
end
