require_relative '../db/config'
require_relative 'models/senator'
require_relative 'models/representative'


def list_by_state(state)
  string = "Senators:\n"
  Senator.where(state: state).sort_by {|sen| sen.last_name}.each do |sen|
    string << "#{sen.name}: #{sen.party}\n"
  end

  string << "\nRepresentatives:\n"
  Representative.where(state: state).each do |rep|
    string << "#{rep.name}: #{rep.party}\n"
  end
  string
end

def percentage_by_gender(gender)
  gender.upcase!
  puts gender
  if gender != "M" && gender != "F"
    return "invalid gender, at least according to senatorial norms"
  end

  percentage_by_gender_branch(gender, Representative) + "\n" +
  percentage_by_gender_branch(gender, Senator)
end

def percentage_by_gender_branch(gender, branch)
  active = branch.where(in_office: true)
  active_gender = active.where(gender: gender).size
  percentage = (active_gender.to_f / active.size).round(2) * 100
  "#{gender} #{branch.to_s} #{active_gender} - #{percentage}"
end


def state_list
  sorted_states = CongressPerson.pluck("DISTINCT state").sort_by do |state|
    CongressPerson.where(state: state, in_office: true).size
  end
 
  string = ""
  sorted_states.reverse.each do |state|
    rep_count = Representative.where(state: state, in_office: true).size
    sen_count = Senator.where(state: state, in_office: true).size
    string << "#{state}: #{sen_count} Senators, #{rep_count} Reps\n"
  end
  string
end

def count
  "Senators: #{Senator.all.size}  Reps: #{Representative.all.size}"
end

# puts state_list
# puts list_by_state('NJ')
puts count
# puts percentage_by_gender('M')
# puts percentage_by_gender('F')
# Senator.all.each { |sen| puts sen.phone }
