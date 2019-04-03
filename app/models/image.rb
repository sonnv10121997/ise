class Image < ApplicationRecord
  mount_uploader :file, FileUploader

  belongs_to :imageable, polymorphic: true

  validates_presence_of :file

  rails_admin do
    configure :imageable do
      visible false
    end
  end
end
