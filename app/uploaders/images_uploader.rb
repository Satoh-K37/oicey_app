class ImagesUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog
  # S3にアップロードする場合
  if Rails.env.production? || Rails.env.staging?
    storage :fog
  else
    storage :file
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # アップロードファイルの保存先
  def store_dir
    if Rails.env.test? #テスト画像は一括削除できるようにフォルダを別にする
      "uploads_#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  process resize_to_fit: [150, 50]
  # process resize_to_limit: [300, 200]

  #
  # def scale(width, height)
  #   # do something
  # end
  # サムネイル画像
  version :thumb do
    process resize_to_fit: [150, 50]
  end

  # version :middle do
  #   process resize_to_fill: [188, 188]
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
    # 許可する画像の拡張子
    def extension_whitelist
      %w(jpg jpeg gif png)
    end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

    # 保存するファイルの命名規則
    def filename
      # "something.jpg" if original_filename
      # 日付でファイルを作成
      if original_filename.present?
        time = Time.now
        name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
        name.downcase
      end
      # これもしかして、複数の画像が投稿されるときは全く同じタイミングで画像が保存されるから命名が一つしかされない感じなのでは？
      # 
    end
  
    protected
    # 一意となるトークンを作成
    # def secure_token
    #   var = :"@#{mounted_as}_secure_token"
    #   model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    # end
end
