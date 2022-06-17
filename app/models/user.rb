class User < ApplicationRecord
  has_secure_password
  # mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :cpf, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil?}

  before_validation :cpf_valid?

  private
    def cpf_valid?
      errors.add(:cpf, 'is invalid') unless CPF.new(cpf).valid?
    end
  
end