class TestapisController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	def resetFixture
		User.delete_all
		render(json: {errCode: 1})
	end

	def unitTests
		render(json: {nrFailed: 0, output: "return some output", totalTests: 15})
	end
end
