class Article < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 3000 }
  validates :user_id, presence: true

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  # mount for images
  mount_uploader :image, ImageUploader

end
