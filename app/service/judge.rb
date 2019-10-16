module Judge_System
 class Text

   def initialize(card)
     @str = card
   end

   def valid
     @result_error = nil
     if /^[^ ]+ [^ ]+ [^ ]+ [^ ]+ [^ ]+ [^ ]+/ == @str
       @result_error = '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
     elsif /^[^ ]+ [^ ]+ [^ ]+ [^ ]+ ([^ ]+)$/ !~ @str
       @result_error = '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
     else
       @input_array = @str.split

       if @result_error == nil
         error = []
         input_numbers = [@input_array[0].delete("C,D,S,H"),@input_array[1].delete("C,D,S,H"), @input_array[2].delete("C,D,S,H"),@input_array[3].delete("C,D,S,H"), @input_array[4].delete("C,D,S,H")]
         @input_letters = [@input_array[0].delete("0-9"),@input_array[1].delete("0-9"),@input_array[2].delete("0-9"),@input_array[3].delete("0-9"),@input_array[4].delete("0-9")]
         unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[0] && /\b[CDSH]\b/ === @input_letters[0]
           error.push("1番目のカード指定文字が不正です。(#{@input_array[0]})<br>")
         end

         unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[1] && /\b[CDSH]\b/ === @input_letters[1]
           error.push("2番目のカード指定文字が不正です。(#{@input_array[1]})<br>")
         end

         unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[2] && /\b[CDSH]\b/ === @input_letters[2]
           error.push("3番目のカード指定文字が不正です。(#{@input_array[2]})<br>")
         end

         unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[3] && /\b[CDSH]\b/ === @input_letters[3]
           error.push("4番目のカード指定文字が不正です。(#{@input_array[3]})<br>")
         end

         unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[4] && /\b[CDSH]\b/ === @input_letters[4]
           error.push("5番目のカード指定文字が不正です。(#{@input_array[4]})<br>")
         end

         if error != []
           error.push("半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。")
           @result_error = error.join
         else @result_error = nil
         if @input_array.uniq.length != @input_array.length
           @result_error = "カードが重複しています。"

         end
         end
         @result_error
       end
     end
   end


     def judge
     @result = nil
     if @result_error == nil
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