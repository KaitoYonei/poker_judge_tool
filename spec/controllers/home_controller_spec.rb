require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#valid" do

    describe "入力形式の間違いをはじく" do
      context "6文字以上の場合" do
        it '「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」と表示される' do
          post :judge, params: abc
          text = Text.new()
          expect(text.valid).to eq nil
          expect(@result_error_add).to eq nil
        end
      end

      context "4文字以下(スペース不足・無し含む)、もしくはスペース位置や数が不適切な場合" do
        let(:params) { { :input => "G3H1 C5H1 H13" } }
        example '「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」と表示される' do
          post :judge, params: params
          expect(@result).to eq nil
          expect(@result_error).to == '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
          expect(@result_error_add).to eq nil
        end
      end
    end

    describe "各要素に不適切な文字が含まれている場合をはじく" do
      context "1つ目の要素が不適切な場合" do
        let(:params) { { :input => "G3 H1 C5 H1 H13" } }
        example "「1番目のカード指定文字が不正です。(1番目の要素を表示)半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」と表示される" do
          post :judge, params: params
          expect(@result).to eq nil
          @result_error.should include "1番目のカード指定文字が不正です。(G3)<br>"
          expect(@result_error_add).to eq "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end
      end
      context "2つ目の要素が不適切な場合" do
          let(:params) { { :input => "H7 H21 C5 D4 S9" } }
          example "「2番目のカード指定文字が不正です。(2番目の要素を表示)半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」と表示される" do
            post :judge, params: params
            @result_error.should include "2番目のカード指定文字が不正です。(H21)<br>"
            expect(@result_error_add).to eq "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        end
      end
      context "3つ目の要素が不適切な場合" do
        example "「3番目のカード指定文字が不正です。(3番目の要素を表示)半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」と表示される" do

        end
      end
      context "4つ目の要素が不適切な場合" do
        example "「4番目のカード指定文字が不正です。(4番目の要素を表示)半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」と表示される" do

        end
      end
      context "5つ目の要素が不適切な場合" do
        example "「5番目のカード指定文字が不正です。(5番目の要素を表示)半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」と表示される" do

        end
      end
    end

    describe "要素の重複をはじく" do
      context "入力された要素に重複がある場合" do
        let(:params) { { :input => "S4 H1 C5 H1 H13" } }
        example "「カードが重複しています。」と表示される" do
          post :judge, params: params
          expect(@result).to eq nil
          expect(@result_error).to eq "カードが重複しています。"
          expect(@result_error_add).to eq nil
        end
      end
    end

    describe "役を判定する" do
      context "全ての要素が正しい形式で入力されている場合" do
        context "同じスートで数字が連続する5枚のカードで構成されている場合" do
          example "「ストレートフラッシュ」と表示される" do

          end
        end
        context "同じ数字のカードが4枚含まれる場合" do
          example "「フォー・オブ・ア・カインド」と表示される" do

          end
        end
        context "同じ数字のカード3枚と、別の同じ数字のカード2枚で構成されている場合" do
          example "「フルハウス」と表示される" do

          end
        end
        context "同じスートのカード5枚で構成されている場合" do
          example "「フラッシュ」と表示される" do

          end
        end
        context "数字が連続した5枚のカードによって構成されている場合" do
          example "「ストレート」と表示される" do

          end
        end
        context "同じ数字の札3枚と数字の違う2枚の札から構成されている場合" do
          example "「スリー・オブ・ア・カインド」と表示される" do

          end
        end
        context "同じ数の2枚組を2組と他のカード1枚で構成されている場合" do
          example "「ツーペア」と表示される" do

          end
        end
        context "同じ数字の2枚組とそれぞれ異なった数字の札3枚によって構成されている場合" do
          example "「ワンペア」と表示される" do

          end
        end
        context "上述の役が1つも成⽴しない場合" do
          example "「ハイカード」と表示される" do

          end
        end
      end
    end

  end

end
