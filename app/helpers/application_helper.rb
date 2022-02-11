# frozen_string_literal: true

module ApplicationHelper
  def style(type)
    styles = { success: 'alert-success', danger: 'alert-danger', notice: 'alert-warning' }
    styles[:"#{type}"] || 'alert-info'
  end
end
