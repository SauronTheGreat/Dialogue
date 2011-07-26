# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.



class ApplicationController < ActionController::Base
  require 'pdfkit'

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate_user!
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller?
      "registrations"
    else
      "application"
    end
  end
end
