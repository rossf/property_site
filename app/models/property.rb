class Property
  include Dynamoid::Document
  
  field :title_en
  field :title_vi
  field :description_en
  field :description_vi
  field :price, :integer 
  field :bedrooms, :integer
  field :bathrooms, :integer
  field :agreement_type, :set => ['rental', 'sale']
  field :type, :set => ['condominium', 'apartment', 'house', 'share']
  field :swiming_pool, :boolean
  field :air_conditioning, :boolean
  
  has_many :pictures
  
  validates :title_en, presence: true, if: "title_vi.nil?"
  validates :title_vi, presence: true, if: "title_en.nil?"
  validates :description_en, presence: true, if: "description_vi.nil?"
  validates :description_vi, presence: true, if: "description_en.nil?"
  validates_numericality_of :price, :bedrooms, :bathrooms, numericality: { greater_than: 0 }, allow_nil: true
  
  include Sunspot::Dynamoid
  searchable do
    text :title_en, :title_vi, :description_en, :description_vi
    time :updated_at
    integer :price, :bedrooms, :bathrooms
    boolean :swimming_pool, :air_conditionings
  end
  
  def self.featured
    begin 
      return Property.all
    rescue
      return nil
    end
  end
end