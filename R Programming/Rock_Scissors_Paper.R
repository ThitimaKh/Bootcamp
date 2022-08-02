
# HOMEWORK PROJECT01 ROCK_SCISSORS_PAPER

rock_scissors_paper <- function(){
  win <- 0
  lose <- 0
  tie <- 0
  actions <- c("rock", "scissors", "paper") 
  while(TRUE){
    user_hand <- tolower(readline("Take your pick: ")) 
    if (user_hand == "exit"){
      return("Exit Game!")
      break
    }
    computer_hand <- sample(actions, 1, replace = TRUE)
    if (user_hand == computer_hand){
      tie <- tie + 1
      print("Draw!")
    } else if(user_hand == "rock" & computer_hand == "scissors"){
      print("You Win!")
      win <- win + 1
    } else if (user_hand == "paper" & computer_hand == "rock"){
      print("You Win!")
      win <- win + 1
    } else if (user_hand == "scissors" & computer_hand == "paper"){
      print("You Win!")
      win <- win +1
    }  else if (user_hand == "paper" & computer_hand == "scissors"){
      print("You Lose!")
      lose <- lose + 1
    } else if (user_hand == "scissors" & computer_hand == "rock"){
      print("You Lose!")
      lose <- lose +1
    } else if (user_hand == "rock" & computer_hand == "paper"){
      print("You Lose!")
      lose <- lose +1
    } else {
      print("Sorry you can pick 'rock scissors paper or exit' in this game!")
    }
    print(paste(user_hand, " VS ",computer_hand))
    print(paste("Won:", win,"Lost:", lose, "Tie:", tie))
  } 
}

rock_scissors_paper()







