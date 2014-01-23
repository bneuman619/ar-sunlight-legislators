require 'csv'

class SunlightLegislatorsImporter
  def self.import(filename)
    CSV.table(File.open(filename)).each do |row|
      row.each do |field, value|
        row[:phone] = self.scrub_pn(row[:phone])
        row[:fax] = self.scrub_pn(row[:fax])
        row[:in_office] = row[:in_office] == 1 ? true : false
      end
    end
  end

  def self.scrub_pn(pn)
    pn.gsub(/\D/, '')
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
