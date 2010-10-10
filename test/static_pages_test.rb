require 'test_helper'

module Ignition
  class StaticPagesTest < ActionController::IntegrationTest
    test 'additional routes' do
      get 'extra-pages/hello'

      assert_response :success
      assert_template 'pages/hello'
    end

    test 'should get top-level page' do
      get 'hello'

      assert_response :success
      assert_template 'pages/hello'
    end

    test 'should get nested page' do
      get 'nested/page'

      assert_response :success
      assert_template 'pages/nested/page'
    end

    test 'should give 404 error' do
      get 'non-existant'

      assert_response :missing
    end

    test 'should not allow access to file below pages directory' do
      get '../layouts/application'

      assert_response :missing
    end

    test 'should cascade to next routes' do
      get 'time'

      assert_response :success
      assert_template 'dynamic/time'
    end
  end
end
