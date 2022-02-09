# frozen_string_literal: true

module ApplicationHelper
  def current_user_is_author?(object)
    object&.author == current_user
  end
end
