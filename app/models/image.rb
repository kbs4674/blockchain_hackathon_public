class Image < ApplicationRecord
    mount_uploader :file, ImageUploader
end
