require 'json'

module HouseholdItemsHelper

  def item_volume_json
    # Read a file.
    File.read(File.dirname(__FILE__) + '/household_items.json')
  end

  def item_volume_hash
    # Convert JSON to Ruby Hash.
    JSON.parse(item_volume_json)
  end
  # module_function :item_volume_hash

end

# p HouseholdItemsHelper.item_volume_hash
