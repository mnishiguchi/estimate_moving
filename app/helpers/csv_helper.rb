module CsvHelper

  # This class represents a process of rendering and sending csv data of
  # a specified moving object.
  class MovingCsv

    def initialize(moving, controller)
      @moving          = moving
      @household_items = moving.household_items
      @controller      = controller
      # @view            = controller.view_context
    end

    def send_data
      # http://api.rubyonrails.org/classes/ActionDispatch/Request.html#method-i-headers
      @controller.send_data render_csv, {
        type:        "application/csv",
        filename:    "#{@moving.name}-#{Date.today}.csv",
        disposition: "attachment"
      }
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
end
