require 'test_helper'

module Ignition
  class RoutingTest < ActionController::IntegrationTest
    test 'top-level page' do
      get 'hello'

      assert_response :success
      assert_template 'pages/hello'
    end

    test 'nested page' do
      get 'nested/page'

      assert_response :success
      assert_template 'pages/nested/page'
    end

    test '404 errors' do
      assert_raises ActionController::RoutingError do
        get 'non-existant'
      end
    end

    test 'directory access restricted' do
      assert_raises ActionController::RoutingError do
        get '../layouts/application'
      end
    end

    test 'route cascades' do
      get 'time'

      assert_response :success
      assert_template 'time/now'
    end
  end
end

