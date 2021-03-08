class Image < ApplicationRecord
  mount_uploaders :url, ImagesUploader
  belongs_to :post,optional: true
end