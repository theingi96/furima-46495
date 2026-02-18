class User < ApplicationRecord
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :birthday, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers' }, allow_nil: true

  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  validates :last_name,  presence: true, format: { with: VALID_NAME_REGEX, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'is invalid. Input full-width characters' }

  VALID_KANA_REGEX = /\A[ァ-ヶー]+\z/
  validates :last_name_kana,  presence: true, format: { with: VALID_KANA_REGEX, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, presence: true, format: { with: VALID_KANA_REGEX, message: 'is invalid. Input full-width katakana characters' }

end
