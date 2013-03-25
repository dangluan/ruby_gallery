class AlbumPhoto < ActiveRecord::Base
  attr_accessible :photo, :list_id
  attr_accessor :photo_file_name
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end