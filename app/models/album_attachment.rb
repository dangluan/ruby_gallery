class AlbumAttachment < ActiveRecord::Base
  has_many :album_photos, dependent: :destroy
end