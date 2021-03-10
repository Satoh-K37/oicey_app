class Image < ApplicationRecord
  belongs_to :post
  # , dependent: :destroy
  mount_uploader :url, ImagesUploader
end
