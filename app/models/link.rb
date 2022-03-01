# frozen_string_literal: true

class Link < ApplicationRecord
  GIST_REGEXP = %r{^https://gist.github.com/\w*/\w*}.freeze

  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, format: URI::DEFAULT_PARSER.make_regexp

  def gist?
    url =~ GIST_REGEXP
  end
end
