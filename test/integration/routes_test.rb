require 'test_helper'

# FYI: ActionDispatch::IntegrationTest inherits from ActiveSupport::TestCase
class RouteTest < ActionDispatch::IntegrationTest

	#######################################################################
	# METHOD: test_route_for_users_add
	#
	# DESCRIPTION:
	# Tests the route for the path /users/add.
	#######################################################################
	def test_route_for_users_add

		# This verifies that the second parameter can be used to generate the first
		assert_generates('/users/add', {controller: "users", action: "add"})

		# This verifies that the second parameter and the first one match
		assert_recognizes({controller: 'users', action: 'add'}, {path: '/users/add', method: :post})

		# This call simulates boths of the calls above in one
		assert_routing({path: '/users/add', method: :post}, {controller: 'users', action: 'add'})
	end

	#######################################################################
	# METHOD: test_route_for_pages_home
	#
	# DESCRIPTION:
	# Tests the route for the path /.
	#######################################################################
	def test_route_for_pages_home
		assert_routing({path: '/', method: :get}, {controller: 'pages', action: 'home'})
	end

	#######################################################################
	# METHOD: test_route_for_users_login
	#
	# DESCRIPTION:
	# Tests the route for the path /users/login.
	#######################################################################
	def test_route_for_users_login
		assert_routing({path: '/users/login', method: :post}, {controller: 'users', action: 'login'})
	end

	#######################################################################
	# METHOD: test_route_for_users_logout
	#
	# DESCRIPTION:
	# Tests the route for the path /users/logout.
	#######################################################################
	def test_route_for_users_logout
		assert_routing({path: '/users/logout', method: :post}, {controller: 'users', action: 'logout'})
	end

	#######################################################################
	# METHOD: test_route_for_TESTAPI_resetFixture
	#
	# DESCRIPTION:
	# Tests the route for the path /TESTAPI/resetFixture.
	#######################################################################
	def test_route_for_TESTAPI_resetFixture
		assert_routing({path: '/TESTAPI/resetFixture', method: :post}, {controller: 'testapis', action: 'resetFixture'})
	end

	#######################################################################
	# METHOD: test_route_for_TESTAPI_unitTests
	#
	# DESCRIPTION:
	# Tests the route for the path /TESTAPI/unitTests.
	#######################################################################
	def test_route_for_TESTAPI_unitTests
		assert_routing({path: '/TESTAPI/unitTests', method: :post}, {controller: 'testapis', action: 'unitTests'})
	end
end