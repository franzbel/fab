class System < ActiveRecord::Base
  has_many :components
  belongs_to :aircraft
end
