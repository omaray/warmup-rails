class User < ActiveRecord::Base
	validates(:username, presence: true, length: { maximum: 128 }, uniqueness: true)
	validates(:password, length: { maximum: 128 })
end