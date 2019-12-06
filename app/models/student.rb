class Student < ActiveRecord::Base
has_many :applications
has_many :programs, through: :applications
has_secure_password
end
