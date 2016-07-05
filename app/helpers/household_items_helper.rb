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

  # Return json data that is required for the HighCharts.js bar chart.
  # Data structure:
  # - categories: ['Africa', 'America', 'Asia', 'Europe', 'Oceania']
  # - data: [107, 31, 635, 203, 2]
  def json_for_bar_chart(moving)
    # Obtain all the tag names of the specified moving.
    tag_names = moving.tags.map(&:name)

    # Obtain the values corresponding to each tag name.
    data_hash = tag_names.map { |tag_name| moving.volume_by_tag(tag_name) }

    # Return array of arrays.
    [tag_names, data_hash]
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
