class UsersController < ApplicationController
	skip_before_filter  :verify_authenticity_token

	#######################################################################
	# METHOD: add
	#
	# DESCRIPTION:
	# Adds a new user to the data storage. Ensures the user is unique
	# and that the passed parameters are valid.
	#######################################################################
	def add

		# Ensure the basics are valid
		errorCode = validate()
		if (errorCode != SUCCESS)
			puts "Hit an error code when basic validating"
			return error_response(errorCode)
		end

		# Ensure the user doesn't already exist
		if (User.find_by_username(params["user"]))
			puts "Seems like the user already exists"
			return error_response(ERR_USER_EXISTS)
		end

		# Create the user in the database
		@user = User.create(username: params["user"], password: params["password"], count: 1)
		respond_to do |format|
			format.html { render "logged" }
			format.json { render json: {errCode: SUCCESS, count: 1} }
		end
	end

	#######################################################################
	# METHOD: login
	#
	# DESCRIPTION:
	# Logs in a user that is already added. Ensures the passed parameters
	# are valid and that user does exist.
	#######################################################################
	def login

		# Ensure the basics are valid
		errorCode = validate()
		if (errorCode != SUCCESS)
			puts "Hit an error when basic validating"
			return error_response(ERR_BAD_CREDENTIALS)		
		end

		# Ensure the user exists
		@user = User.find_by_username(params["user"])
		if (@user.nil?)
			puts "The user doesn't exist in the database"
			return error_response(ERR_BAD_CREDENTIALS)
		end

		# Ensure the passwords match
		if (@user.password != params["password"])
			puts "The passwords don't match"
			return error_response(ERR_BAD_CREDENTIALS)
		end

		# Update the login count
		@user.count = @user.count + 1
		@user.save

		respond_to do |format|
			format.html { render "logged" }
			format.json { render json: {errCode: SUCCESS, count: @user.count} }
		end
	end

	#######################################################################
	# METHOD: logout
	#
	# DESCRIPTION:
	# Logs out the user that is already logged in. At this point it simply
	# redirects to the home page.
	#######################################################################
	def logout
		redirect_to :controller => 'pages', :action => 'home'
	end

	#######################################################################
	# HELPER: validate
	#
	# DESCRIPTION:
	# Validates the entries present in the params variable (JSON data).
	#######################################################################
	def validate
		if (params["user"].empty?)
			return ERR_BAD_USERNAME
		end

		if (params["user"].length > MAX_USERNAME_LENGTH)
			return ERR_BAD_USERNAME
		end

		if (params["password"].length > MAX_PASSWORD_LENGTH)
			return ERR_BAD_PASSWORD
		end

		return SUCCESS
	end

	#######################################################################
	# HELPER: error_response
	#
	# DESCRIPTION:
	# Sets the flash notice string and renders the right message in the
	# home page or simply returns the right JSON error code.
	#######################################################################
	def error_response(errorCode)
		flash[:notice] = ERROR_TO_STRING[errorCode]

		respond_to do |format|
			format.html { redirect_to :controller => 'pages', :action => 'home' }
			format.json { render json: {errCode: errorCode} }
		end
	end
end
