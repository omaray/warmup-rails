class UsersController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	def add

		# Ensure the basics are valid
		errorCode = validate()
		if (errorCode != SUCCESS)
			puts "Hit an error code when basic validating"
			render(json: {errCode: errorCode})
			return
		end

		# Ensure the user doesn't already exist
		if (User.find_by_username(params["user"]))
			puts "Seems like the user already exists"
			render(json: {errCode: ERR_USER_EXISTS})
			return
		end

		# Create the user in the database
		User.create(username: params["user"], password: params["password"], count: 1)
		render(json: {errCode: SUCCESS, count: 1})		
	end

	def login

		# Ensure the basics are valid
		errorCode = validate()
		if (errorCode != SUCCESS)
			puts "Hit an error when basic validating"
			render(json: {errCode: ERR_BAD_CREDENTIALS})
			return
		end

		# Ensure the user exists
		user = User.find_by_username(params["user"])
		if (user.nil?)
			puts "The user doesn't exist in the database"
			render(json: {errCode: ERR_BAD_CREDENTIALS})
			return
		end

		# Ensure the passwords match
		if (user.password != params["password"])
			puts "The passwords don't match"
			render(json: {errCode: ERR_BAD_CREDENTIALS})
			return
		end

		# Update the login count
		user.count = user.count + 1
		user.save

		render(json: {errCode: SUCCESS, count: user.count})
	end

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
end
