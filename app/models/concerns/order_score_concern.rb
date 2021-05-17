module OrderScoreConcern
  extend ActiveSupport::Concern

  included do
    scope :order_by_score, -> { order(score: :desc) }
  end
end
