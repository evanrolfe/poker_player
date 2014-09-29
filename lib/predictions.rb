if amount_to_call > 0
  if ideal_bet > highest_bet
    #Opp predicted to bet more than we are willing to put in
    if predicted_move == 'bet' && predicted_bet > ideal_bet - current_bet
      fold
    else
      bet(ideal_bet - current_bet)
    end
  elsif ideal_bet == highest_bet
    #Opp predicted to bet when we will only call
    if predicted_move == 'bet'
      fold
    else
      call
    end
  else
    #Opp predicted to fold, then we might as well call
    if predicted_move == 'fold'
      call
    else
      fold
    end
  end
else
  if ideal_bet > current_bet

    #Opp predicted to bet more than we are willing to put in
    if predicted_move == 'bet' && predicted_bet > ideal_bet - current_bet
      call
    else
      bet(ideal_bet - current_bet)
    end

  else
    call
  end
end
