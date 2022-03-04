# frozen_string_literal: true

module AnswersHelper
  def vote_by_current_user_for(object)
    return nil unless current_user.voted_for?(object)

    current_user.votes.find_by(votable_type: object.class.to_s, votable_id: object.id)
  end
end
