
def display_card(card)
  #["H", 4] or ["D", "A"]
  suit = case card.first
            when "D" then "Diamonds"
            when "H" then "Hearts"
            when "C" then "Clubs"
            when "S" then "Spades"
          end

  face_value = card.last

  if ["J", "Q", "K", "A"].include?(card.last)
    face_value = case card.last
                  when "A" then "Ace"
                  when "K" then "King"
                  when "Q" then "Queen"
                  when "J" then "Jack"
                end
  end

  "#{face_value} of #{suit}" # => ex. "Ace of Hearts"
end

def say(str = "")
  puts "=> #{str}"
end

def calculate_total(cards) # cards is [["H", "3"], ["D", "J"], ... ]
  arr = cards.map{|element| element[1]}

  total = 0
  arr.each do |a|
    if a == "A"
      total += 11
    else
      total += a.to_i == 0 ? 10 : a.to_i
    end
  end

  #correct for Aces
  arr.select{|element| element == "A"}.count.times do
    break if total <= 21
    total -= 10 
  end

  total
end

####################################
##         START HERE             ##
####################################

suits = ["H", "D", "S", "C"]
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

deck = suits.product(cards) #[["H", "2"], ["D", "J"], ... ]

####################################
##         DEAL CARDS             ##
####################################

mycards = []
dealercards = []

# take turns dealing cards
say "Dealing cards..."
mycards     << deck.delete_at(rand(deck.size))
dealercards << deck.delete_at(rand(deck.size))
mycards     << deck.delete_at(rand(deck.size))
dealercards << deck.delete_at(rand(deck.size))

say "Cards dealt. There are now #{deck.size} cards in the deck."
puts ""

say "------ Dealer's cards: ------"
say "Dealer's first card is hidden."
say "Dealer's second card is: #{display_card(dealercards[1])}"

puts ""
say "------ Your cards: ------"
say "Your first card is: #{display_card(mycards[0])}"
say "Your second card is: #{display_card(mycards[1])}"

####################################
##         PLAYER TURN            ##
####################################

mytotal = calculate_total(mycards)
say "Your total is: #{mytotal}"

if mytotal == 21
  say "***** You hit 21! You win! *****"
  exit
end

while mytotal < 21 do
  puts ""
  say "What would you like to do? 1) hit 2) stay"
  response = gets.chomp
  
  if !["1", "2"].include?(response) 
    say "ERROR: must enter 1 or 2"
    next
  end

  if response == "2"
    say "You chose to stay at #{mytotal}."
    break;
  end

  new_card = deck.delete_at(rand(deck.size))
  say "There are now #{deck.size} cards in the deck."
  say "You drew #{display_card(new_card)}"
  mycards << new_card
  mytotal = calculate_total(mycards)
  say "Your total is: #{mytotal}"
  
  if mytotal == 21
    say "***** You hit 21! You win! *****"
    say "------ Dealer's cards: ------"
    say "Dealer's first card is: #{display_card(dealercards[0])}"
    say "Dealer's second card is: #{display_card(dealercards[1])}"
    say "Dealer's total is #{calculate_total(dealercards)}"
    exit
  elsif mytotal > 21
    say "**** Oh, it looks like you busted! Your total is #{mytotal}. *****"
    say "------ Dealer's cards: ------"
    say "Dealer's first card is: #{display_card(dealercards[0])}"
    say "Dealer's second card is: #{display_card(dealercards[1])}"
    say "Dealer's total is #{calculate_total(dealercards)}"
    exit
  end

end

####################################
##         DEALER TURN            ##
####################################

say "Dealer's turn... "

dealertotal = calculate_total(dealercards)

if dealertotal == 21
  say "**** Dealer hit 21! You your total was #{mytotal}. You lost. ****"
  exit
elsif dealertotal > 17
  say "Dealer stays." 
end

while dealertotal < 17 do
  say "Dealer total is #{dealertotal}. Dealer hits. Issuing new card..."
  new_card = deck.delete_at(rand(deck.size))
  say "There are now #{deck.size} cards in the deck."
  say "Dealer drew #{display_card(new_card)}"
  dealercards << new_card
  dealertotal = calculate_total(dealercards)

  if dealertotal == 21
    say "**** Dealer hit 21! You your total was #{mytotal}. You lost. ****"
    exit
  elsif dealertotal > 21
    say "**** Dealer busted! Dealer total is #{dealertotal}. Your total is #{mytotal}. You win! ****"
    exit
  elsif dealertotal > 17 
    say "Dealer stays."
  end
end

####################################
##         Compare                ##
####################################

say "------ Dealer's cards: ------"
dealercards.each do |card|
  say "#{display_card(card)}"
end
say "Dealer's total is #{dealertotal}"

puts ""

say "------ Your cards: ------"
mycards.each do |card|
  say "#{display_card(card)}"
end
say "Your total is #{mytotal}"

puts ""

if dealertotal > mytotal
  say "**** Dealer wins! ****"
elsif dealertotal < mytotal
  say "**** You win! ****"
else
  say "*** It's a push! ****"
end

puts ""

exit