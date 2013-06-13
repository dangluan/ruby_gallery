class AlbumPhoto < ActiveRecord::Base
  attr_accessible :photo
  belongs_to :album_photoable, polymorphic: true
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, url: "/system/:attachment/:id/:style/:filename"
end