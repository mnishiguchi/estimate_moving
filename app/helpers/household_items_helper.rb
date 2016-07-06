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

  def json_for_bar_chart(moving)
    # Obtain all the tag names of the specified moving.
    tag_names = moving.tags.map(&:name)

    # Create an array of name-value pairs and sort it by value.
    data_pairs = tag_names.map do |tag_name|
      [
        tag_name,
        moving.volume_by_tag(tag_name)
      ]
    end.sort { |a, b| b[1] <=> a[1] }

    # Unzip the array of arrays into two arrays.
    names, values = data_pairs.transpose

    # Return a json object that contains two arrays.
    { names: names, values: values }.to_json
  end


  # Return json data that is required for the HighCharts.js pie chart.
  def json_for_pie_chart(moving)
    # Obtain all the tag names of the specified moving.
    tag_names = moving.tags.map(&:name)

    # Structure the data as per required by the HighCharts.js pie chart.
    data_hash = tag_names.map! do |tag_name|
      [
        [:name, tag_name],
        [:y, moving.volume_by_tag(tag_name)]
      ]
      .to_h
    end

    # Convert the hash to json so that Javascript can understand it.
    data_hash.to_json
  end
end
