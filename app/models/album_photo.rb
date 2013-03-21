class AlbumPhoto < ActiveRecord::Base
  attr_accessible :photo
  
  belongs_to :album_attachment
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end