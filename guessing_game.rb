@Player1 = {
	:id 1
	:num_attempts 0
	:score 0
}
@Player2 = {
	:id 2
	:num_attempts 0
	:score 0
}


puts "Player 1, please enter your name"
@Player1[:name] = gets.chomp

puts "Player 2, please enter your name"
@Player2[:name] = gets.chomp



def generate_num_one
	Random.new.rand(1,20)
end

def generate_num_two
	Random.new.rand(1,20)
end

def answer(one, two)
	one + two
end




def get_answer
	gets.chomp.to_i
end

def get_other(player)
	(player[:id] == 1) ? @Player2 : @Player1
end



def game_over(player)
	player[:num_attempts] >= 3
end



def run_turn(num_one, num_two, player)
	puts "What is #{num_one} + #{num_two}"
	answer = get_answer
	if answer == answer(num_one, num_two)
		puts "That is correct"
	else
		puts "That is incorrect"
		player[:num_attempts] += 1
		if game_over(player)
			puts "Game over. #{player[:name]} loses. #{get_other(player)[:name]} wins."
			break
		end
	end
end

def run_game
	turn_num = 0
	run = true
	while run
		if turn_num % 2
			player = @Player1
		else
			player = @Player2
		end
		num_one = generate_num_one
		num_two = generate_num_two
		answer = answer(num_one, num_two)
		run_turn(num_one, num_two, player)
	end
end

run_game


		