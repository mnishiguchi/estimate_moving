module CsvHelper

  # This class represents a process of rendering and sending csv data of
  # a specified moving object.
  class MovingCsv
    attr_reader :config, :data

    def initialize(moving)
      @moving          = moving
      @household_items = moving.household_items
      @config = {
        type:        "application/csv",
        filename:    "#{@moving.name}-#{Date.today}.csv",
        disposition: "attachment"
      }
      @data = render_csv
    end

    private

      def render_csv
        # Set options if needed (e.g. :col_sep, :headers, etc)
        # http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html#DEFAULT_OPTIONS
        options = { headers: true }

        # Specify the attributes to extract.
        attributes = %w(name volume quantity volume_subtotal description)

        output = CSV.generate(options) do |csv|
          # Write column names to the first row.
          csv << attributes

          @household_items.each do |household_item|
            # Write each record as an array of values for the attributes.
            csv << attributes.map{ |attr| household_item.send(attr) }
          end
        end
        output
      end
  end

  class DefaultVolumesCsv
    attr_reader :config, :data

    def initialize(default_volumes)
      @default_volumes = default_volumes
      @config = {
        type:        "application/csv",
        filename:    "#{@default_volumes.name}-#{Date.today}.csv",
        disposition: "attachment"
      }
      @data = render_csv
    end

    private

      def render_csv
        # Set options if needed (e.g. :col_sep, :headers, etc)
        # http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html#DEFAULT_OPTIONS
        options = { headers: true }

        # Specify the attributes to extract.
        attributes = %w(name volume)

        output = CSV.generate(options) do |csv|
          # Write column names to the first row.
          csv << attributes

          @default_volumes.each do |default_volume|
            # Write each record as an array of values for the attributes.
            csv << attributes.map{ |attr| default_volume.send(attr) }
          end
        end
        output
      end
  end
end
