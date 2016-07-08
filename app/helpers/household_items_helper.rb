require 'json'

module HouseholdItemsHelper

  # A hash of name-volume pairs (in ft3)
  def item_volume_hash
    # Convert JSON to Ruby Hash.
    JSON.parse(item_volume_json)
  end

  # A JSON of name-volume pairs in an appropriate unit according to the moving.
  def item_volume_json(moving)

    # Read a file.
    items_json = File.read(File.dirname(__FILE__) + '/household_items.json')

    # Convert volumes to an appropriate unit.
    case moving.unit
    when "us" then items_json
    when "metric"
      metric_json = JSON.parse(items_json).map do |name, volume|
        [ name, ft3_to_m3(volume) ]
      end.to_h.to_json
    else
      raise 'Invalid unit'
    end
  end

  # Generates data in the structure that is required for the bar chart.
  def json_for_bar_chart(moving)
    # Obtain all the tag names of the specified moving.
    tag_names = moving.tags.map(&:name)

    # Create an array of name-value pairs and sort it by value.
    data_pairs = tag_names.map do |tag_name|
      volume = moving.volume_of_tag(tag_name)
      [
        tag_name,
        moving.correct_volume(volume)
      ]
    end.sort { |a, b| b[1] <=> a[1] }

    # Unzip the array of arrays into two arrays.
    names, values = data_pairs.transpose

    # Return a json object that contains two arrays.
    { names: names, values: values }.to_json
  end

  # # Return json data that is required for the HighCharts.js pie chart.
  # def json_for_pie_chart(moving)
  #   # Obtain all the tag names of the specified moving.
  #   tag_names = moving.tags.map(&:name)
  #
  #   # Structure the data as per required by the HighCharts.js pie chart.
  #   data_hash = tag_names.map! do |tag_name|
  #     [
  #       [:name, tag_name],
  #       [:y, moving.volume_of_tag(tag_name)]
  #     ]
  #     .to_h
  #   end
  #
  #   # Convert the hash to json so that Javascript can understand it.
  #   data_hash.to_json
  # end
end
