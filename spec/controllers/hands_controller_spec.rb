require 'rails_helper'

RSpec.describe HandsController, type: :controller do

  describe 'POST #result'

    render_views

   context '6文字以上' do
    before do
      post :result, params:{hand: "ha he df gr ww j"} , session: {}
    end
    it 'bodyに「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」という記述があること' do
      expect(response.body).to include('5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）')
    end
   end


  context '4文字以下もしくは不正な半角スペースが存在する' do
    before do
      post :result, params:{hand: "hedf gr ww j"} , session: {}
    end
    it 'bodyに「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」という記述があること' do
      expect(response.body).to include('5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）')
    end
  end


  context '1番目の文字が不正' do
    before do
      post :result, params:{hand: "H18 D3 S24 cf H1"} , session: {}
    end
    it 'bodyに「1番目のカード指定文字が不正です。（H18）」という記述があること' do
      expect(response.body).to include('1番目のカード指定文字が不正です。(H18)')
    end
    it 'bodyに「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という記述があること' do
      expect(response.body).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '2番目の文字が不正' do
    before do
      post :result, params:{hand: "f1 23 G1 H2 S10"} , session: {}
    end
    it 'bodyに「2番目のカード指定文字が不正です。（23）」という記述があること' do
      expect(response.body).to include('2番目のカード指定文字が不正です。(23)')
    end
    it 'bodyに「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という記述があること' do
      expect(response.body).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '3番目の文字が不正' do
    before do
      post :result, params:{hand: "-s D1 S_4 ff S1"} , session: {}
    end
    it 'bodyに「3番目のカード指定文字が不正です。（S_4）」という記述があること' do
      expect(response.body).to include('3番目のカード指定文字が不正です。(S_4)')
    end
    it 'bodyに「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という記述があること' do
      expect(response.body).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '4番目の文字が不正' do
    before do
      post :result, params:{hand: "a H1 S2 j y71"} , session: {}
    end
    it 'bodyに「4番目のカード指定文字が不正です。（j）」という記述があること' do
      expect(response.body).to include('4番目のカード指定文字が不正です。(j)')
    end
    it 'bodyに「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という記述があること' do
      expect(response.body).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '5番目の文字が不正' do
    before do
      post :result, params:{hand: "H1 S1 C1 D1 D14"} , session: {}
    end
    it 'bodyに「5番目のカード指定文字が不正です。（D14）」という記述があること' do
      expect(response.body).to include('5番目のカード指定文字が不正です。(D14)')
    end
    it 'bodyに「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という記述があること' do
      expect(response.body).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '同じスートで数字が連続する5枚のカードで構成されている' do
    before do
      post :result, params:{hand: "H1 H2 H3 H4 H5"} , session: {}
    end
    it 'bodyに「ストレートフラッシュ」という記述があること' do
      expect(response.body).to include('ストレートフラッシュ')
    end
    before do
      post :result, params:{hand: "S11 S13 S12 S1 S10"} , session: {}
    end
    it 'bodyに「ストレートフラッシュ」という記述があること' do
      expect(response.body).to include('ストレートフラッシュ')
    end
  end

  context '同じ数字のカードが4枚含まれる' do
    before do
      post :result, params:{hand: "H11 S11 D11 H4 C11"} , session: {}
    end
    it 'bodyに「フォー・オブ・ア・カインド」という記述があること' do
      expect(response.body).to include('フォー・オブ・ア・カインド')
    end
  end

  context '同じ数字のカード3枚と、別の同じ数字のカード2枚で構成されている' do
    before do
      post :result, params:{hand: "H2 S2 C4 H4 D2"} , session: {}
    end
    it 'bodyに「フルハウス」という記述があること' do
      expect(response.body).to include('フルハウス')
    end
  end

  context '同じスートのカード5枚で構成されている' do
    before do
      post :result, params:{hand: "H11 H12 H13 H2 H1"} , session: {}
    end
    it 'bodyに「フラッシュ」という記述があること' do
      expect(response.body).to include('フラッシュ')
    end
  end

  context '数字が連続した5枚のカードによって構成されている' do
    before do
      post :result, params:{hand: "H2 S1 C4 C3 C5"} , session: {}
    end
    it 'bodyに「ストレート」という記述があること' do
      expect(response.body).to include('ストレート')
    end
    before do
      post :result, params:{hand: "S13 S12 S11 C1 D10"} , session: {}
    end
    it 'bodyに「ストレート」という記述があること' do
      expect(response.body).to include('ストレート')
    end
  end

  context '同じ数字の札3枚と数字の違う2枚の札から構成されている' do
    before do
      post :result, params:{hand: "H2 S2 C2 C4 C12"} , session: {}
    end
    it 'bodyに「スリー・オブ・ア・カインド」という記述があること' do
      expect(response.body).to include('スリー・オブ・ア・カインド')
    end
  end

  context '同じ数の2枚組を2組と他のカード1枚で構成されている' do
    before do
      post :result, params:{hand: "H9 S9 C4 H4 D11"} , session: {}
    end
    it 'bodyに「ツーペア」という記述があること' do
      expect(response.body).to include('ツーペア')
    end
  end

  context '同じ数字の2枚組とそれぞれ異なった数字の札3枚によって構成されている' do
    before do
      post :result, params:{hand: "H2 S12 C4 H4 D1"} , session: {}
    end
    it 'bodyに「ワンペア」という記述があること' do
      expect(response.body).to include('ワンペア')
    end
  end

  context '役が1つも成⽴しない' do
    before do
      post :result, params:{hand: "H9 S1 C4 H8 H2"} , session: {}
    end
    it 'bodyに「ハイカード」という記述があること' do
      expect(response.body).to include('ハイカード')
    end
  end

end