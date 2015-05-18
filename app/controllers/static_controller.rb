class StaticController < ApplicationController
  before_action only: :landing_page do |c| 
    c.available_to "logged_out"
  end
  
  def landing_page

  end

end