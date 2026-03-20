        ## HOMEWORK ##
##1.rock ,paper ,scissor
#sample()

#create list of hands
hands <- c('rock','paper','scissors')
#create var to store score
my_score <-0
computer_score <-0

#rock paper scissors 
rock_paper_scissors <-function()
{
  counter <-TRUE
  while (counter)
  {
    input <- tolower(readline("Rock,Paper,Scissors.....:" ))
    #print(input)
    if (input=='exit')
    {print("good bye!")
      print(paste("your score is : ",my_score))
      print(paste("computer score is :",computer_score))
      counter<-FALSE
    }
    
    else if (input == "rock" || input=="paper" || input =="scissors" )
    {
      ##game logic here  
      ai_move <- sample(hands,1)
      print(paste("Your hand is :" ,input))
      print(paste("Computer hand is:",ai_move))
      if (input=='rock') 
      {
        if(ai_move == 'paper')
        {
          computer_score <- computer_score+1
          print("You lost!")
        }
        else if (ai_move=='scissors')
        {
          my_score <-my_score+1
          print("You win!!")
        }
        
        else {print("Drawn")}
        
      }
      else if (input=='paper') 
      {
        if(ai_move == 'scissors')
        {
          computer_score <- computer_score+1
          print("You lost!")
        }
        else if (ai_move=='rock')
        {
          my_score <-my_score+1
          print("You win!!")
        }
        else {print("Drawn")}
        
      }
      else if (input=='scissors') 
      {
        if(ai_move == 'rock')
        {
          computer_score <- computer_score+1
          print("You lost!")
        }
        else if (ai_move=='paper')
        {
          my_score <-my_score+1
          print("You win!!")
        }
        else {print("Drawn")}
        
      }
      
      
    }
    else {
      print("Invalid input. input is rock,paper,scissors or exit")
      counter<-FALSE
    }
  }
  
}

