# frozen_string_literal: true

module ApplicationHelper
  def style(type)
    styles = { success: 'alert-success', alert: 'alert-danger', notice: 'alert-warning' }
    styles[:"#{type}"]
  end
end
