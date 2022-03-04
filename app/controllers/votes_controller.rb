# frozen_string_literal: true

class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @votable = vote_params[:votable_type].classify.constantize.find(vote_params[:votable_id])

    return head(:forbidden) if current_user.voted_for?(@votable)

    @vote = current_user.votes.create(vote_params.merge(votable: @votable))

    respond_to do |format|
      format.json { render json: @vote }
    end
  end

  def destroy
    @vote = Vote.find(params[:id])

    return head(:forbidden) unless current_user.voted_for?(@vote.votable)

    @vote.destroy
    redirect_to resources_path(@vote)
  end

  private

  def resources_path(vote)
    vote.votable_type == 'Question' ? vote.votable : vote.votable.question
  end

  def vote_params
    params.require(:vote).permit(:value, :votable_type, :votable_id)
  end
end
