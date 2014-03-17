require 'test_helper'

# FYI: ActionController::TestCase inherits from ActiveSupport::TestCase
class UsersControllerTest < ActionController::TestCase

	#######################################################################
	# METHOD: test_add_with_empty_username
	#
	# DESCRIPTION:
	# Tests that adding a user with an empty username fails.
	#######################################################################
	def test_add_with_empty_username

		puts "\nCalling test_add_with_empty_username"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:add, {'user' => "", 'password' => "myPassword"})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{ERR_BAD_USERNAME}}", response.body)

		# Print the flash for visual validation
		puts flash[:notice]

		# Assert the flash was populated with the right message
		assert_equal(flash[:notice], ERROR_TO_STRING[ERR_BAD_USERNAME])
	end

	#######################################################################
	# METHOD: test_add_with_username_too_long
	#
	# DESCRIPTION:
	# Tests that adding a user with a username too long fails.
	#######################################################################
	def test_add_with_username_too_long

		puts "\nCalling test_add_with_username_too_long"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:add, {'user' => 'a'*129, 'password' => "myPassword"})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{ERR_BAD_USERNAME}}", response.body)

		# Print the flash for visual validation
		puts flash[:notice]

		# Assert the flash was populated with the right message
		assert_equal(flash[:notice], ERROR_TO_STRING[ERR_BAD_USERNAME])
	end

	#######################################################################
	# METHOD: test_add_with_password_too_long
	#
	# DESCRIPTION:
	# Tests that adding a user with a password too long fails.
	#######################################################################
	def test_add_with_password_too_long

		puts "\nCalling test_add_with_password_too_long"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:add, {'user' => "Eric", 'password' => "a"*129})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{ERR_BAD_PASSWORD}}", response.body)

		# Print the flash for visual validation
		puts flash[:notice]

		# Assert the flash was populated with the right message
		assert_equal(flash[:notice], ERROR_TO_STRING[ERR_BAD_PASSWORD])
	end

	#######################################################################
	# METHOD: test_add_with_existing_user
	#
	# DESCRIPTION:
	# Tests that adding an already existing user fails.
	#######################################################################
	def test_add_with_existing_user

		puts "\nCalling test_add_with_existing_user"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:add, {'user' => "Johnny", 'password' => "HisPassword"})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{ERR_USER_EXISTS}}", response.body)

		# Print the flash for visual validation
		puts flash[:notice]

		# Assert the flash was populated with the right message
		assert_equal(flash[:notice], ERROR_TO_STRING[ERR_USER_EXISTS])
	end

	#######################################################################
	# METHOD: test_add_with_valid_user
	#
	# DESCRIPTION:
	# Tests that adding a valid new user succeeds as expeted.
	#######################################################################
	def test_add_with_valid_user

		puts "\nCalling test_add_with_valid_user"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:add, {'user' => "Michel", 'password' => "DasPassword"})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{SUCCESS},\"count\":1}", response.body)

		# Assert that a new user was added in the database
		assert_not_nil(User.find_by(username: "Michel"))

		# Assert that the instance variable exists for the view to use
		assert_not_nil(assigns["user"])
	end

	#######################################################################
	# METHOD: test_login_with_empty_username
	#
	# DESCRIPTION:
	# Tests that logging a user with an empty username fails.
	#######################################################################
	def test_login_with_empty_username

		puts "\nCalling test_login_with_empty_username"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:login, {'user' => "", 'password' => "myPassword"})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{ERR_BAD_CREDENTIALS}}", response.body)

		# Print the flash for visual validation
		puts flash[:notice]

		# Assert the flash was populated with the right message
		assert_equal(flash[:notice], ERROR_TO_STRING[ERR_BAD_CREDENTIALS])
	end

	#######################################################################
	# METHOD: test_login_with_username_too_long
	#
	# DESCRIPTION:
	# Tests that logging a user with a username too long fails.
	#######################################################################
	def test_login_with_username_too_long

		puts "\nCalling test_login_with_username_too_long"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:login, {'user' => 'a'*129, 'password' => "myPassword"})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{ERR_BAD_CREDENTIALS}}", response.body)

		# Print the flash for visual validation
		puts flash[:notice]

		# Assert the flash was populated with the right message
		assert_equal(flash[:notice], ERROR_TO_STRING[ERR_BAD_CREDENTIALS])
	end

	#######################################################################
	# METHOD: test_login_with_password_too_long
	#
	# DESCRIPTION:
	# Tests that logging a user with a password too long fails.
	#######################################################################
	def test_login_with_password_too_long

		puts "\nCalling test_login_with_password_too_long"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:login, {'user' => "Eric", 'password' => "a"*129})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{ERR_BAD_CREDENTIALS}}", response.body)

		# Print the flash for visual validation
		puts flash[:notice]

		# Assert the flash was populated with the right message
		assert_equal(flash[:notice], ERROR_TO_STRING[ERR_BAD_CREDENTIALS])
	end

	#######################################################################
	# METHOD: test_login_with_non_existing_user
	#
	# DESCRIPTION:
	# Tests that logging a user that doesn't exist fails.
	#######################################################################
	def test_login_with_non_existing_user

		puts "\nCalling test_login_with_non_existing_user"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:login, {'user' => "Eric", 'password' => "APassword"})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{ERR_BAD_CREDENTIALS}}", response.body)

		# Print the flash for visual validation
		puts flash[:notice]

		# Assert the flash was populated with the right message
		assert_equal(flash[:notice], ERROR_TO_STRING[ERR_BAD_CREDENTIALS])
	end

	#######################################################################
	# METHOD: test_login_with_wrong_password
	#
	# DESCRIPTION:
	# Tests that logging an existing user with the wrong password fails.
	#######################################################################
	def test_login_with_wrong_password

		puts "\nCalling test_login_with_wrong_password"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:login, {'user' => "Johnny", 'password' => "WrongPassword"})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{ERR_BAD_CREDENTIALS}}", response.body)

		# Print the flash for visual validation
		puts flash[:notice]

		# Assert the flash was populated with the right message
		assert_equal(flash[:notice], ERROR_TO_STRING[ERR_BAD_CREDENTIALS])
	end

	#######################################################################
	# METHOD: test_login_with_valid_user
	#
	# DESCRIPTION:
	# Tests that logging an existing user with the right password succeeds.
	#######################################################################
	def test_login_with_valid_user

		puts "\nCalling test_login_with_valid_user"

		# Set the header to ensure we get back the json response
		@request.headers["Accept"] = "application/json"

		# Define the HTTP method to call with the right params
		post(:login, {'user' => "Johnny", 'password' => "HisPassword"})

		# Print the response for visual validation
		puts response.body

		# Assert the response has the right JSON
		assert_equal("{\"errCode\":#{SUCCESS},\"count\":2}", response.body)

		# Assert that the instance variable exists for the view to use
		assert_not_nil(assigns["user"])
	end
end