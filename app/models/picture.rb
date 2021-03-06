class Picture
  include Dynamoid::Document
  include Dynamoid::Paperclip

  embedded_in :property, :inverse_of => :pictures

  has_dynamoid_attached_file :attachment,
    :path           => ':attachment/:id/:style.:extension',
    :storage        => :s3,
    :url            => ':s3_alias_url',
    :s3_host_alias  => 'something.cloudfront.net',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
    :styles => {
      :original => ['1920x1680>', :jpg],
      :small    => ['100x100#',   :jpg],
      :medium   => ['250x250',    :jpg],
      :large    => ['500x500>',   :jpg]
    },
    :convert_options => { :all => '-background white -flatten +matte' }
end