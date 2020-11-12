class Prototype < ApplicationRecord
  # belongs_toとhas_manyの関連先は関連名（必ずしもモデル名とは限らない）
  # belongs_toは1対1の関係なので、関連名は単数表記になる
  # has_manyは1対多なので、関連名は複数表記
  belongs_to :user
  has_one_attached :image 
  has_many :comments, dependent: :destroy

  validates :image, presence: true
end
