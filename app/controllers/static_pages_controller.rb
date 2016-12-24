class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end
  
  def dashboard_view
    #params[:view] = 'month'
    @view = params[:view]
    @template = @view+'_dashboard_container'
  end
  
  def dashboard_reload
    @view = params[:view]
    respond_to do |format|
      format.js
    end
  end
  
  
end
