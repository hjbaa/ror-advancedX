# frozen_string_literal: true

module Attachable
  extend ActiveSupport::Concern

  included do
    has_many_attached :files
    before_destroy :destroy_attached_files
  end

  private

  def destroy_attached_files
    files.each(&:purge)
  end
end
