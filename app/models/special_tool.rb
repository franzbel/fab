class SpecialTool < ActiveRecord::Base
  belongs_to :inspection
  has_attached_file :photo,
                    styles: { medium: '150x150>', thumb: '100x100>'},
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :photo,
                                    content_type: /\Aimage\/.*\Z/


end
