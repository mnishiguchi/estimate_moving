require 'csv'

class Array
  def to_tsv
    CSV.generate(col_sep: "\t") do |csv|
      self.each do |x|
        csv << (x.kind_of?(Enumerable) ? x.map(&:to_s) : [x])
      end
    end
  end
end
