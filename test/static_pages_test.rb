require 'test_helper'

module Ignition
  class StaticPagesTest < ActionController::IntegrationTest
    test 'should get top-level page' do
      get 'hello'

      assert_response :success
      assert_template 'hello'
    end

    test 'should get nested page' do
      get 'nested/page'

      assert_response :success
      assert_template 'nested/page'
    end

    test 'should give 404 error' do
      assert_raise ActionController::RoutingError do
        get 'non-existant'
      end
    end

    test 'should not allow access to file below pages directory' do
      assert_raise ActionController::RoutingError do
        get '../layouts/application'
      end
    end
  end
end
