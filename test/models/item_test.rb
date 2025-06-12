require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "should not save item without name" do
    item = Item.new
    assert_not item.save, "Saved the item without a title"
  end
end
