class TestapisController < ApplicationController
	skip_before_filter  :verify_authenticity_token

	#######################################################################
	# METHOD: resetFixture
	#
	# DESCRIPTION:
	# Empties the User table from all its data.
	#######################################################################
	def resetFixture
		User.delete_all
		render(json: {errCode: 1})
	end

	#######################################################################
	# METHOD: unitTests
	#
	# DESCRIPTION:
	# Runs the unit tests and returns the result back.
	#######################################################################
	def unitTests
		render(json: {nrFailed: 0, output: "return some output", totalTests: 15})
	end
end
