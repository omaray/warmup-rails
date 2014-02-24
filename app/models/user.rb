class User < ActiveRecord::Base
	validates(:username, presence: true, length: { maximum: 128 }, uniqueness: true)
end
