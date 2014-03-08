require 'test_helper'

# FYI: ActiveSupport::TestCase inherits from MiniTest::Unit::TestCase
class UserTest < ActiveSupport::TestCase

	#######################################################################
	# METHOD: test_valid_user
	#
	# DESCRIPTION:
	# Creates a new user in memory and asserts it's valid.
	#######################################################################
	def test_valid_user
		user = User.new(username: "Marcus", password: "His password", count: 1)
		assert(user.valid?)
	end

	#######################################################################
	# METHOD: test_username_not_present
	#
	# DESCRIPTION:
	# Creates a new user without a username and asserts it's invalid.
	#######################################################################
	def test_username_not_present
		user = User.new(password: "mypass", count: 1)
		assert_not(user.valid?, "User is valid when there is no username")
	end

	#######################################################################
	# METHOD: test_username_empty
	#
	# DESCRIPTION:
	# Creates a new user with an empty username and asserts it's invalid.
	#######################################################################
	def test_username_empty
		user = User.new(username: "", password: "mypass", count: 1)
		assert_not(user.valid?, "User is valid when the username is empty")
	end

	#######################################################################
	# METHOD: test_username_too_long
	#
	# DESCRIPTION:
	# Creates a new user with a username too long and asserts it's invalid.
	#######################################################################
	def test_username_too_long
		user = User.new(username: "a"*129, password: "mypass", count: 1)
		assert_not(user.valid?, "User is valid when the username is too long")
	end

	#######################################################################
	# METHOD: test_username_uniqueness
	#
	# DESCRIPTION:
	# Creates a new user with an existing username already in the db and
	# asserts that the second user is invalid.
	#######################################################################
	def test_username_uniqueness
		user = User.new(username: "Marcus", password: "hispass", count: 1)
		user.save
		user_with_same_username = user.dup
		assert_not(user_with_same_username.valid?, "User is valid when has a duplicated username")
	end

	#######################################################################
	# METHOD: test_password_too_long
	#
	# DESCRIPTION:
	# Creates a new user with a password too long and asserts it's invalid.
	#######################################################################
	def test_password_too_long
		user = User.new(username: "Marcus", password: "a"*129, count: 1)
		assert_not(user.valid?, "User is valid when the password is too long")
	end
end