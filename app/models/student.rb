class Student < ActiveRecord::Base
has_many :applications
has_many :programs, through: :applications
has_secure_password
include ActiveModel::Validations
validates :name, presence: true

validates :email,    :presence => true,
                     :uniqueness => true
                     

end
