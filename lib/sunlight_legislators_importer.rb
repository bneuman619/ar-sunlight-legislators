require 'csv'
require_relative '../app/models/senator'
require_relative '../app/models/representative'

class SunlightLegislatorsImporter
  def self.import(filename)
    rows = CSV.table(File.open(filename)).each do |row|
      real_row = {}
      real_row[:first_name] = row[:first_name]
      real_row[:middle_name] = row[:middle_name]
      real_row[:last_name] = row[:last_name]
      real_row[:state] = row[:state]
      real_row[:phone] = self.scrub_pn(row[:phone])
      real_row[:fax] = self.scrub_pn(row[:fax])
      real_row[:website] = row[:website]
      real_row[:email_form] = row[:email_form]
      real_row[:party] = row[:party]
      real_row[:gender] = row[:gender]
      real_row[:birthdate] = row[:birthdate]
      real_row[:twitter_id] = row[:twitter_id]
      real_row[:in_office] = row[:in_office] == 1 ? true : false
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
