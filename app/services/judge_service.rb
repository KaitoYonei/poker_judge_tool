module JudgeService

  JUDGE_STRONG_SCORE = {
      "ストレートフラッシュ"=>9,
      "フォー・オブ・ア・カインド"=>8,
      "フルハウス"=>7,
      "フラッシュ"=>6,
      "ストレート"=>5,
      "スリー・オブ・ア・カインド"=>4,
      "ツーペア"=>3,
      "ワンペア"=>2,
      "ハイカード"=>1
  }

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
     error = []
     if SIX_OR_MORE == @cards
       error.push(FORM_ERROR)
     elsif FOUR_OR_LESS !~ @cards
       error.push(FORM_ERROR)
     else
       @input_array = @cards.split

       if @error_message == nil
         input_numbers = [@input_array[0].delete("C,D,S,H"),@input_array[1].delete("C,D,S,H"), @input_array[2].delete("C,D,S,H"),@input_array[3].delete("C,D,S,H"), @input_array[4].delete("C,D,S,H")]
         @input_letters = [@input_array[0].delete("0-9"),@input_array[1].delete("0-9"),@input_array[2].delete("0-9"),@input_array[3].delete("0-9"),@input_array[4].delete("0-9")]
         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[0] && ALPHABET_C_D_H_S === @input_letters[0]
           error.push("1"+WRONG_CARD+"(#{@input_array[0]})")
         end

         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[1] && ALPHABET_C_D_H_S === @input_letters[1]
           error.push("2"+WRONG_CARD+"(#{@input_array[1]})")
         end

         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[2] && ALPHABET_C_D_H_S === @input_letters[2]
           error.push("3"+WRONG_CARD+"(#{@input_array[2]})")
         end

         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[3] && ALPHABET_C_D_H_S === @input_letters[3]
           error.push("4"+WRONG_CARD+"(#{@input_array[3]})")
         end

         unless NUMBER_ONE_TO_THIRTEEN === input_numbers[4] && ALPHABET_C_D_H_S === @input_letters[4]
           error.push("5"+WRONG_CARD+"(#{@input_array[4]})")
         end

         if error == [] && @input_array.uniq.length != @input_array.length
           error.push(DUPLICATE)
         end

       end

     end
     if error != []
       @error_message = error
     end
     @error_message
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
        elsif numbers.uniq.length == 4
          @result = "ワンペア"
        else
          @result = "ハイカード"
        end
     end
     @result
     end

 end
end



