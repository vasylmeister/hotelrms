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
    @year = params[:year].to_i || 2020
    respond_to do |format|
      format.js
    end
  end
  
  
end
