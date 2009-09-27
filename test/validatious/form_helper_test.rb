# encoding: utf-8
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

module Test::Unit::Assertions

  #
  # Assert that a piece of HTML includes the class name.
  #
  def assert_has_class(class_name, html, message = nil)
    classes = /class="([^"]*)"/.match(html)[1].split(' ')
    full_message = build_message(message, "<?>\nexpected to include class(es) <?>.\n", html, class_name)

    assert_block(full_message) do
      class_name.split(' ').all? { |cname| classes.include?(cname) }
    end
  end

end

require 'action_view/test_case'

class FormHelperTest < ::ActionView::TestCase

  include ActionView::Helpers::FormHelper

  test "required :text_field" do
    assert_has_class 'required', text_field(:bogus_item, :name)
    assert_has_class 'required text', text_field(:bogus_item, :name, :class => 'text')
  end

  test "required :password_field" do
    assert_has_class "required", password_field(:bogus_item, :name)
    assert_has_class "required text", password_field(:bogus_item, :name, :class => "text")
  end

  test "required :text_area" do
    assert_has_class "required", text_area(:bogus_item, :body)
    assert_has_class "required text", text_area(:bogus_item, :body, :class => "text")
  end

  test "required :check_box" do # a.k.a. "acceptance required"
    assert_has_class "required", check_box(:bogus_item, :signed)
    assert_has_class "required boolean", check_box(:bogus_item, :signed, :class => "boolean")
  end

  test "required :radio_button" do
    # TODO
  end

  test "confirmation_of-field" do
    # TODO: Add form-builder-test as well
    assert_has_class "confirmation-of_name", text_field(:bogus_item, :name_confirmation)
    assert_has_class "confirmation-of_name text", text_field(:bogus_item, :name_confirmation, :class => "text")
  end

  test "regular label" do
    assert_equal "<label for=\"bogus_item_name\">Name</label>", label(:bogus_item, :name)
  end

  test "label with title" do
    assert_equal "<label for=\"bogus_item_name\" title=\"craaazy\">Name</label>",
                 label(:bogus_item, :name, nil, :title => "craaazy")
  end

  test "label without title" do
    assert_equal "<label for=\"bogus_item_name\" title=\"Name\">Your name</label>",
                 label(:bogus_item, :name, "Your name")
  end

end
