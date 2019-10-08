class HomeController < ApplicationController

  def top
    $result00 = nil
    $result0 = nil
    $result1 = nil
    $result2 = nil
    $result3 = nil
    $result4 = nil
    $result = nil
  end

  def judge
    $str = "#{params[:input]}"
    $result00 = nil
    $result0 = nil
    $result1 = nil
    $result2 = nil
    $result3 = nil
    $result4 = nil
    $result = nil
    if /^[^ ]+ [^ ]+ [^ ]+ [^ ]+ [^ ]+ [^ ]+/ === $str then
      $result00 = %Q[5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）]
    elsif /^[^ ]+ [^ ]+ [^ ]+ [^ ]+ ([^ ]+)$/ !~ $str then
      $result00 = %Q[5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）]
    else
      input_array = $str.split

      if input_array.uniq.length != input_array.length
        $result00 = "カードが重複しています。"
      else
        input_numbers = [input_array[0].delete("C,D,S,H"),input_array[1].delete("C,D,S,H"), input_array[2].delete("C,D,S,H"),input_array[3].delete("C,D,S,H"), input_array[4].delete("C,D,S,H")]
        input_letters = [input_array[0].delete("0-9"),input_array[1].delete("0-9"),input_array[2].delete("0-9"),input_array[3].delete("0-9"),input_array[4].delete("0-9")]

        unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[0] && /\b[CDSH]\b/ === input_letters[0]
          $result0 = "1番目のカード指定文字が不正です。(#{input_array[0]})"
          $result00 = "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end

        unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[1] && /\b[CDSH]\b/ === input_letters[1]
          $result1 = "2番目のカード指定文字が不正です。(#{input_array[1]})"
          $result00 = "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end

        unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[2] && /\b[CDSH]\b/ === input_letters[2]
          $result2 = "3番目のカード指定文字が不正です。(#{input_array[2]})"
          $result00 = "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end

        unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[3] && /\b[CDSH]\b/ === input_letters[3]
          $result3 = "4番目のカード指定文字が不正です。(#{input_array[3]})"
          $result00 = "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end

        unless /\b[1-9]\b|\b1[0-3]\b/ === input_numbers[4] && /\b[CDSH]\b/ === input_letters[4]
          $result4 = "5番目のカード指定文字が不正です。(#{input_array[4]})"
          $result00 = "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end

        unless $result0 || $result1 || $result2 || $result3 || $result4
          numbers = [input_array[0].delete("C,D,S,H").to_i,input_array[1].delete("C,D,S,H").to_i, input_array[2].delete("C,D,S,H").to_i,input_array[3].delete("C,D,S,H").to_i, input_array[4].delete("C,D,S,H").to_i].sort

          if numbers[4] === numbers[3] + 1 && numbers[3] === numbers[2] + 1 && numbers[2] === numbers[1] + 1 && numbers[1] === numbers[0] + 1 && input_letters[0] === input_letters[1] && input_letters[0] === input_letters[1] && input_letters[1] === input_letters[2] && input_letters[2] === input_letters[3] && input_letters[3] === input_letters[4]
            $result = "ストレートフラッシュ"
          elsif numbers[0] === numbers[3] || numbers[1] === numbers[4]
            $result = "フォー・オブ・ア・カインド"
          elsif numbers[0] === numbers[2] && numbers[3] === numbers[4] || numbers[2] === numbers[4] && numbers[0] === numbers[1]
            $result = "フルハウス"
          elsif input_letters[0] === input_letters[1] && input_letters[0] === input_letters[1] && input_letters[1] === input_letters[2] && input_letters[2] === input_letters[3] && input_letters[3] === input_letters[4]
            $result = "フラッシュ"
          elsif numbers[4] === numbers[3] + 1 && numbers[3] === numbers[2] + 1 && numbers[2] === numbers[1] + 1 && numbers[1] === numbers[0] + 1
            $result = "ストレート"
          elsif numbers[0] === numbers[2] || numbers[1] === numbers[3] || numbers[2] === numbers[4]
            $result = "スリー・オブ・ア・カインド"
          elsif numbers.uniq.length == 3
            $result = "ツーペア"
          elsif numbers.uniq.length == 2
            $result = "ワンペア"
          else
            $result = "ハイカード"
          end
          
          
        end
      end
    end
    render("top")
  end


end
