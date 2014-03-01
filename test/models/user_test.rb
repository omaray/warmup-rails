require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def test_valid_user
		user = User.new(username: "Marcus", password: "His password", count: 1)
		assert(user.valid?)
	end

	def test_username_not_present
		user = User.new(password: "mypass", count: 1)
		assert_not(user.valid?, "User is valid when there is no username")
	end

	def test_username_empty
		user = User.new(username: "", password: "mypass", count: 1)
		assert_not(user.valid?, "User is valid when the username is empty")
	end

	def test_username_too_long
		user = User.new(username: "a"*129, password: "mypass", count: 1)
		assert_not(user.valid?, "User is valid when the username is too long")
	end

	def test_username_uniqueness
		user = User.new(username: "Marcus", password: "hispass", count: 1)
		user.save
		user_with_same_username = user.dup
		assert_not(user_with_same_username.valid?, "User is valid when has a duplicated username")
	end

	def test_password_too_long
		user = User.new(username: "Marcus", password: "a"*129, count: 1)
		assert_not(user.valid?, "User is valid when the password is too long")
	end
end