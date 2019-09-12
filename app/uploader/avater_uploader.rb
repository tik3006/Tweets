class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.development?
    # ローカルに保存する
    storage :file
  elsif Rails.env.test?
    # ローカルに保存する
    storage :file
  else
    # S3などの外部に保存する
    storage :fog
  end

  # S3のディレクトリ名
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 許可する画像の拡張子
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # 画像名をリネームさせる(日付時間はダメ絶対)
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  # 一意となるトークンを作成
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  # 画像サムネイル
  version :thumb do
    process resize_to_fill: [316, 316]
  end

  # アップロードの時点で指定サイズに収まるようにしておく
  process :resize_to_limit => [700, 700]

end