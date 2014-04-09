require 'test_helper'

module Ignition
  class UrlHelpersTest < ActionView::TestCase
    include Rails.application.routes.mounted_helpers

    test 'url helpers' do
      assert_equal '/hello', ignition_engine.page_path('hello')
      assert_equal '/nested/page', ignition_engine.page_path('nested/page')
    end
  end
end
