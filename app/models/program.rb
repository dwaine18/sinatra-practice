class Program < ActiveRecord::Base
has_many :applications
has_many :students, through: :applications
end
