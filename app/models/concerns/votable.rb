module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def rating
    return 0 unless votes.any?

    votes.pluck(:value).reduce { |result, current| result += current }
  end
end
