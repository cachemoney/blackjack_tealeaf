SUIT = ["Clubs", "Diamonds", "Spades", "Hearts"]
def initialize_deck
	card_deck = []
	SUIT.each do |suit|
		# card_hash = {}
		(1..13).each do |card_id|
			card_hash = {}
			card_hash[:suit] = suit
			if card_id == 1
				card_hash[:name] = "Ace"
				card_hash[:value] = 11
				card_deck << card_hash
			elsif card_id == 11
				card_hash[:name] = "Jack"
				card_hash[:value] = 10
				card_deck << card_hash
			elsif card_id == 12
				card_hash[:name] = "Queen"
				card_hash[:value] = 10
				card_deck << card_hash
			elsif card_id == 13
				card_hash[:name] = "King"
				card_hash[:value] = 10
				card_deck << card_hash
			else
				card_hash[:name] = card_id.to_s
				card_hash[:value] = card_id
				card_deck << card_hash
			end
	
    end
    
  end
  card_deck.shuffle
end



def calc_points(player)
	sum = 0
	player.each do |card|
		sum += card[:value]
	end
	sum.to_i
end

def bust?(player)
	calc_points(player) > 21 ? true : false
end

def show_status(player_cards, dealer_cards, game_over)
	if !game_over
		puts "Dealer:\t |XX-XX| |#{dealer_cards[1][:name]} of #{dealer_cards[1][:suit]}| "
		print "You:\t"
		player_cards.each do |card|
			print "|#{card[:name]} of #{card[:suit]}| "
		end
		print "\tTotal Points: #{calc_points(player_cards)}\n"
	else
		print "Dealer:\t"
		dealer_cards.each do |card|
			print "|#{card[:name]} of #{card[:suit]}| "
		end
		print "\n"
		print "You:\t"
		player_cards.each do |card|
			print "|#{card[:name]} of #{card[:suit]}| "
		end
		print "\tTotal Points: #{calc_points(player_cards)}\n"
	end
end

def hit!(player, live_deck)
	player << live_deck
end



def play_hand(deck, p1, d1)
	game_over = false
	p1 << deck.pop
	d1 << deck.pop
	p1 << deck.pop
	d1 << deck.pop
	show_status(p1,d1, game_over)
	puts "(H)it or (S)tay"
	action = gets.chomp
	while (action.downcase == 'h')
		hit!(p1, deck)
		show_status(p1,d1, false)
		break if bust?(p1)
		puts "(H)it or (S)tay"
		action = gets.chomp.downcase
	end
	if (action.downcase == 's' || bust?(p1) )
		puts "Dealer will play out his turn"
		show_status(p1,d1, true)
		while calc_points(d1) <= 17
			hit!(d1, deck)
			show_status(p1,d1, true)
		end
	end
	show_status(p1,d1, true)
end

status = true
while status do
	player = []
	dealer = []
	live_deck = initialize_deck
	play_hand(live_deck, player, dealer)
	status = false
end
puts "Game Over"




