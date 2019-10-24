require "rails_helper"

RSpec.describe JudgeService do

  let!(:judgehands) { Struct.new(:target) { include JudgeService } }

 describe "エラーメッセージ" do

  context '6文字以上' do
    let(:target) { judgehands::JudgeHands.new("S12 S5 D8 C4 H1 H9")}
    it '「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」という文字列が返ること' do
      expect(target.valid).to eq '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
    end
  end

  context '4文字以下もしくは不正な半角スペースが存在する' do
    let(:target) { judgehands::JudgeHands.new("C1 D3 S11")}
    it '「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」という文字列が返ること' do
      expect(target.valid).to eq '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
    end
  end

  context '1番目の文字が不正' do
    let(:target) { judgehands::JudgeHands.new("G1 D3 S1 D2 C5")}
    it '「1番目のカード指定文字が不正です。（G1）」という文字列が返ること' do
      expect(target.valid).to include('1番目のカード指定文字が不正です。(G1)')
    end
    it '「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という文字列が返ること' do
      expect(target.valid).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '2番目の文字が不正' do
    let(:target) { judgehands::JudgeHands.new("S3 S14 S1 S7 S8")}
    it '2番目のカード指定文字が不正です。（S14）」という文字列が返ること' do
      expect(target.valid).to include('2番目のカード指定文字が不正です。(S14)')
    end
    it '「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という文字列が返ること' do
      expect(target.valid).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '3番目の文字が不正' do
    let(:target) { judgehands::JudgeHands.new("C11 D2 S H10 C5")}
    it '「3番目のカード指定文字が不正です。（S）」という文字列が返ること' do
      expect(target.valid).to include('3番目のカード指定文字が不正です。(S)')
    end
    it '「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という文字列が返ること' do
      expect(target.valid).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '4番目の文字が不正' do
    let(:target) { judgehands::JudgeHands.new("H1 S2 H3 k! D1")}
    it '「4番目のカード指定文字が不正です。（k!）」という文字列が返ること' do
      expect(target.valid).to include('4番目のカード指定文字が不正です。(k!)')
    end
    it '「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という文字列が返ること' do
      expect(target.valid).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '5番目の文字が不正' do
    let(:target) { judgehands::JudgeHands.new("S1 H2 D12 C3 hgf")}
    it '「5番目のカード指定文字が不正です。（hgf）」という文字列が返ること' do
      expect(target.valid).to include('5番目のカード指定文字が不正です。(hgf)')
    end
    it '「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という文字列が返ること' do
      expect(target.valid).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end
 end

 describe "リザルトメッセージ" do

  before do
    target.valid
  end

  context '同じスートで数字が連続する5枚のカードで構成されている' do
    let(:target) { judgehands::JudgeHands.new("C5 C3 C6 C4 C7")}
    it '「ストレートフラッシュ」という文字列が返ること' do
      expect(target.judge).to eq ('ストレートフラッシュ')
    end
    let(:target) { judgehands::JudgeHands.new("D1 D13 D11 D12 D10")}
    it '「ストレートフラッシュ」という文字列が返ること' do
      expect(target.judge).to eq ('ストレートフラッシュ')
    end
  end

  context '同じ数字のカードが4枚含まれる' do
    let(:target) { judgehands::JudgeHands.new("H3 S3 D3 H1 C3")}
    it '「フォー・オブ・ア・カインド」という文字列が返ること' do
      expect(target.judge).to eq ('フォー・オブ・ア・カインド')
    end
  end

  context '同じスートのカード5枚で構成されている' do
    let(:target) { judgehands::JudgeHands.new("H11 H12 H13 H2 H1")}
    it '「フラッシュ」という文字列が返ること' do
      expect(target.judge).to eq ('フラッシュ')
    end
  end

  context '数字が連続した5枚のカードによって構成されている' do
    let(:target) { judgehands::JudgeHands.new("H1 S2 C5 C4 C3")}
    it '「ストレート」という文字列が返ること' do
      expect(target.judge).to eq ('ストレート')
    end
    let(:target) { judgehands::JudgeHands.new("S11 D13 S12 C9 D10")}
    it '「ストレート」という文字列が返ること' do
      expect(target.judge).to eq ('ストレート')
    end
  end

  context '同じ数字の札3枚と数字の違う2枚の札から構成されている' do
    let(:target) { judgehands::JudgeHands.new("H12 S12 C12 C4 C2")}
    it '「スリー・オブ・ア・カインド」という文字列が返ること' do
      expect(target.judge).to eq ('スリー・オブ・ア・カインド')
    end
  end

  context '同じ数の2枚組を2組と他のカード1枚で構成されている' do
    let(:target) { judgehands::JudgeHands.new("H2 S6 C4 H4 D2")}
    it '「ツーペア」という文字列が返ること' do
      expect(target.judge).to eq ('ツーペア')
    end
  end

  context '同じ数字の2枚組とそれぞれ異なった数字の札3枚によって構成されている' do
    let(:target) { judgehands::JudgeHands.new("H2 S12 C2 H4 D1")}
    it '「ワンペア」という文字列が返ること' do
      expect(target.judge).to eq ('ワンペア')
    end
  end

  context '役が1つも成⽴しない' do
    let(:target) { judgehands::JudgeHands.new("H8 S1 C4 H3 H2")}
    it '「ハイカード」という文字列が返ること' do
      expect(target.judge).to eq ('ハイカード')
    end
  end
 end
end