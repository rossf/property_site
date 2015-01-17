require 'test_helper'

class PropertyModelTest < ActiveSupport::TestCase
  
  test "should not save property without title" do
    property = Property.new
    assert_not property.save, "Saved without a title"
  end
  
  test "should not save without a desctiption" do
    property = Property.new(title_en: "test")
    assert_not property.save, "Saved without a description"
  end
  
  test "should save with english title and description" do
    property = Property.new(title_en: "test", description_en: "test_description")
    assert property.save, "Failed to save minimum valid property"
  end
end