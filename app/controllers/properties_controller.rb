class PropertiesController < ApplicationController
  def index
    if(params[:agreement_type])
      @properties = Property.where(agreement_type: params[:agreement_type])
    else
      @properties = Property.featured
    end
  end
  
  def new
  end
  
  def search
    @properties = Property.search {fulltext params[:search]}
    render 'index'
  end
end
