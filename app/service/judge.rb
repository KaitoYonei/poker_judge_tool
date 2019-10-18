module JudgeService

 class JudgeHands
   require "request_error"
   require "error_message"
   include RequestError
   include ErrorMessage

   def initialize(card)
     @cards = card
   end

   def valid
     @error_message = nil
     if SIX_OR_MORE == @cards
       @error_message = FORM_ERROR
     elsif FOUR_OR_LESS !~ @cards
       @error_message = FORM_ERROR
     else
       @input_array = @cards.split

       if @error_message == nil
         error = []
         input_numbers = [@input_array[0].delete("C,D,S,H"),@input_array[1].delete("C,D,S,H"), @input_array[2].delete("C,D,S,H"),@input_array[3].delete("C,D,S,H"), @input_array[4].delete("C,D,S,H")]
         @input_letters = [@input_array[0].delete("0-9"),@input_array[1].delete("0-9"),@input_array[2].delete("0-9"),@input_array[3].delete("0-9"),@input_array[4].delete("0-9")]
         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[0] && ALPHABET_C_D_H_S === @input_letters[0]
           error.push("1"+WRONG_CARD+"(#{@input_array[0]})<br>")
         end

         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[1] && ALPHABET_C_D_H_S === @input_letters[1]
           error.push("2"+WRONG_CARD+"(#{@input_array[1]})<br>")
         end

         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[2] && ALPHABET_C_D_H_S === @input_letters[2]
           error.push("3"+WRONG_CARD+"(#{@input_array[2]})<br>")
         end

         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[3] && ALPHABET_C_D_H_S === @input_letters[3]
           error.push("4"+WRONG_CARD+"(#{@input_array[3]})<br>")
         end

         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[4] && ALPHABET_C_D_H_S === @input_letters[4]
           error.push("5"+WRONG_CARD+"(#{@input_array[4]})<br>")
         end

         if error != []
           error.push(WRONG_CARD_MESSAGE)
           @error_message = error.join
         else @error_message = nil
         if @input_array.uniq.length != @input_array.length
           @error_message = DUPLICATE

         end
         end
         @error_message
       end
     end
   end


     def judge
     @result = nil
     if @error_message == nil
       numbers = [@input_array[0].delete("C,D,S,H").to_i,@input_array[1].delete("C,D,S,H").to_i, @input_array[2].delete("C,D,S,H").to_i,@input_array[3].delete("C,D,S,H").to_i,@input_array[4].delete("C,D,S,H").to_i].sort
        if (numbers[4] == numbers[3] + 1 && numbers[3] == numbers[2] + 1 && numbers[2] == numbers[1] + 1 && numbers[1] == numbers[0] + 1 || numbers == [1,10,11,12,13]) && (@input_letters[0] == @input_letters[1] && @input_letters[1] == @input_letters[2] && @input_letters[2] == @input_letters[3] && @input_letters[3] == @input_letters[4])
          @result = "ストレートフラッシュ"
        elsif numbers[0] == numbers[3] || numbers[1] == numbers[4]
          @result = "フォー・オブ・ア・カインド"
        elsif numbers[0] == numbers[2] && numbers[3] == numbers[4] || numbers[2] == numbers[4] && numbers[0] == numbers[1]
          @result = "フルハウス"
        elsif @input_letters[0] == @input_letters[1] && @input_letters[1] == @input_letters[2] && @input_letters[2] == @input_letters[3] && @input_letters[3] == @input_letters[4]
          @result = "フラッシュ"
        elsif numbers[4] == numbers[3] + 1 && numbers[3] == numbers[2] + 1 && numbers[2] == numbers[1] + 1 && numbers[1] == numbers[0] + 1 || numbers == [1,10,11,12,13]
          @result = "ストレート"
        elsif numbers[0] == numbers[2] || numbers[1] == numbers[3] || numbers[2] == numbers[4]
          @result = "スリー・オブ・ア・カインド"
        elsif numbers.uniq.length == 3
          @result = "ツーペア"
        elsif numbers.uniq.length == 2
          @result = "ワンペア"
        else
          @result = "ハイカード"
        end
     end
     @result
    end


 end
end