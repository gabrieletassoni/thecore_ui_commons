class ApplicationController < ActionController::Base
  before_action :setup_white_label

  private

  def setup_white_label
    # Somewhat white label support
    prepend_view_path(["vendor/custombuilds/#{ENV['COMPOSE_PROJECT_NAME']}.#{ENV['BASE_DOMAIN']}/deltas/app/views"]) if ENV['COMPOSE_PROJECT_NAME'].present? && ENV['BASE_DOMAIN'].present?
  end
end
