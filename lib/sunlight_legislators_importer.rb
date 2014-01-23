require 'csv'
require_relative '../app/models/senator'
require_relative '../app/models/representative'

class SunlightLegislatorsImporter
  def self.import(filename)
    rows = CSV.table(File.open(filename)).each do |row|
      real_row = {}
      real_row[:name] = row[:firstname] + " " + row[:middlename] + " " + row[:lastname]
      real_row[:state] = row[:state].to_s
      real_row[:phone] = self.scrub_pn(row[:phone]).to_i
      real_row[:fax] = self.scrub_pn(row[:fax]).to_i
      real_row[:website] = row[:website].to_s
      real_row[:webform] = row[:webform].to_s
      real_row[:party] = row[:party].to_s
      real_row[:gender] = row[:gender].to_s
      real_row[:birthdate] = row[:birthdate].to_s
      real_row[:twitter_id] = row[:twitter_id].to_s
      if row[:in_office] == 0
        real_row[:in_office] = false
      else
        real_row[:in_office] = true
      end
    

      if row[:title] == "Sen"
        Senator.create(real_row)
      elsif row[:title] == "Rep"
        Representative.create(real_row)
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
