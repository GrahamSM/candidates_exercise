# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
	raise '@candidates must be an Array' if @candidates.nil?
	@candidates.each do |x|
		if x[:id] == id
			return x
		end
	end
	puts "Candidate not found"
	nil
end

def has_hundred?(candidate)
	unless candidate.has_key?(:github_points)
		raise InvalidCandidateError, 'candidate must have a :github_points key'
	end
	candidate[:github_points] >=100
end

def ruby_python?(candidate)
	unless candidate.has_key?(:languages)
		raise InvalidCandidateError, 'candidate must have a :languages key'
	end
	candidate[:languages].each do |x|
		if (x == "Ruby" || x == "Python")
			return true
		end
	end
end

def applied_recently?(candidate)
	unless candidate.has_key?(:date_applied)
		raise InvalidCandidateError, 'candidate must have a :date_applied key'
	end
	candidate[:date_applied] < 15.days.ago.to_date
end

def over_seventeen(candidate)
	unless candidate.has_key?(:age)
		raise InvalidCandidateError, 'candidate must have an :age key'
	end
	candidate[:age] > 17
end

def experienced?(candidate)
	unless candidate.has_key?(:years_of_experience)
		raise InvalidCandidateError, 'candidate must have a :years_of_experience key'
	end
	candidate[:years_of_experience] >= 2
end

def qualified_candidates(candidates)
	candidates.select do |x|
		begin
			if (over_seventeen(x) && ruby_python?(x) && has_hundred?(x) && experienced?(x))
				puts "ID: #{x[:id].to_s.green}"
			end
		rescue InvalidCandidateError => e
			puts "The candidates experience could not be determined"
			puts "The reason for this error was: #{e.message}"
		end
	end
end

def nice_print(candidates)
	candidates.each do |x|
		if (over_seventeen(x) && ruby_python?(x) && has_hundred?(x) && experienced?(x))
			puts "ID: #{x[:id].to_s.green}"
		else
			puts "ID: #{x[:id].to_s.red}"
		end
	end
end

def ordered_by_qualifications(candidates)
	candidates = candidates.sort_by{|candidate| [candidate[:years_of_experience],candidate[:github_points]]}
end

def run_repl
	continued = true
	while continued
		puts "Options"
		puts "-------"
		puts "Find 'id'"
		puts "all"
		puts "qualified"
		puts "quit"
		puts ""
		puts "Please select one..."
		puts ""
		input = gets.chomp.downcase
		case input
		when /all/
			nice_print(@candidates)
		when /qualified/
			qualified_candidates(@candidates)
		when /find (\d+)/
			puts find($1.to_i)
		when /quit/
			break
		else
			"Option not recognized"
		end
	end
end
