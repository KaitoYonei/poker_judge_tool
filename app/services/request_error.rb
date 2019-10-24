module RequestError
  #6枚以上の手札を入力している
  SIX_OR_MORE = Regexp.new(/^[^ ]+ [^ ]+ [^ ]+ [^ ]+ [^ ]+ [^ ]+/)

  #4枚以下の手札を入力している、もしくは余分なスペースが付いている
  FOUR_OR_LESS = Regexp.new(/^[^ ]+ [^ ]+ [^ ]+ [^ ]+ ([^ ]+)$/)

  #半角数字1~13である
  NUMBER_ONE_TO_THIRTEEN = Regexp.new(/\b[1-9]\b|\b1[0-3]\b/)

  #半角大文字アルファベットC、D、H、Sのいずれかである
  ALPHABET_C_D_H_S = Regexp.new(/\b[CDSH]\b/)
end