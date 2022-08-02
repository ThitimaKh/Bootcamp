import random

def rock_scissors_paper_game():
  win = 0
  lose = 0
  tie = 0
  actions = ["rock", "scissors", "paper"]

  while True:
    user_hand = input(f"Take your pick:").lower()
    if user_hand == "exit":
      print("Exit Game!")
      break 

    computer_hand = random.choice(actions)
    if user_hand == computer_hand:
      tie += 1
    elif user_hand == "rock" and computer_hand == "scissors":
      win += 1
    elif user_hand == "paper" and computer_hand == "rock":
      win += 1
    elif user_hand == "scissors" and computer_hand == "paper":
      win += 1
    else:
      lose += 1
    print(f"{user_hand} vs. {computer_hand}")
    print(f"Won: {win} \nLost: {lose} \nTie: {tie}\n")
   
  
rock_scissors_paper_game()  
