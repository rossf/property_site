class PropertiesController < ApplicationController
  def index
    @properties = Property.featured
  end
end
