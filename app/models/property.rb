class Property
  include Dynamoid::Document
  
  field :title_en
  field :title_vi
  field :description_en
  field :description_vi
  field :price, :interger 
  field :bedrooms, :integer
  field :bathrooms, :integer
  field :agreement_type, :set => ['rental', 'sale']
  field :swiming_pool, :boolean
  field :air_conditioning, :boolean
  
  has_many :pictures
  
  def featured
    
  end
end