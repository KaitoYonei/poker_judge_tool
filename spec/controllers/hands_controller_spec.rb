require 'rails_helper'

RSpec.describe HandsController, type: :controller do


  it 'リクエストが成功すること' do
    post :result, params:{hand: "H11 C3 S11 D4 S10"} , session: {}
    expect(response.status).to eq 200
  end

  it 'リクエスト失敗時にはステータスコード400が返ること' do
    post :result, params:{hand: "H15 C3 S11 D4 S10"} , session: {}
    expect(response.status).to eq 400
  end

  it 'topテンプレートが表示されること' do
    post :result, params:{hand: "D1 S3 S5 S8 S1"} , session: {}
    expect(response).to render_template(:top)
  end

    render_views

  context '6文字以上' do
    it 'bodyに「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」という記述があること' do
      post :result, params:{hand: "H1 D3 C11 D4 H12 S1"} , session: {}
      expect(response.body).to include('5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）')
    end
  end


  context '4文字以下もしくは不正な半角スペースが存在する' do
    it 'bodyに「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」という記述があること' do
      post :result, params:{hand: "D12 H1 S2 C5"} , session: {}
      expect(response.body).to include('5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）')
    end
  end


  context '1番目の文字が不正' do
    before do
      post :result, params:{hand: "H18 D3 S4 C2 H1"} , session: {}
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
      post :result, params:{hand: "C11 S33 H1 D2 S10"} , session: {}
    end
    it 'bodyに「2番目のカード指定文字が不正です。（S33）」という記述があること' do
      expect(response.body).to include('2番目のカード指定文字が不正です。(S33)')
    end
    it 'bodyに「半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。」という記述があること' do
      expect(response.body).to include('半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。')
    end
  end

  context '3番目の文字が不正' do
    before do
      post :result, params:{hand: "S2 D1 S_4 D12 S1"} , session: {}
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
      post :result, params:{hand: "H5 H1 S2 j D7"} , session: {}
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

  context '重複したカードが存在する' do
    before do
      post :result, params:{hand: "H1 S1 H1 D1 D13"} , session: {}
    end
    it 'bodyに「カードが重複しています。」という記述があること' do
      expect(response.body).to include('カードが重複しています。')
    end
  end

  context '同じスートで数字が連続する5枚のカードで構成されている' do
    it 'bodyに「ストレートフラッシュ」という記述があること' do
      post :result, params:{hand: "H1 H2 H3 H4 H5"} , session: {}
      expect(response.body).to include('ストレートフラッシュ')
    end
    it 'bodyに「ストレートフラッシュ」という記述があること' do
      post :result, params:{hand: "S11 S13 S12 S1 S10"} , session: {}
      expect(response.body).to include('ストレートフラッシュ')
    end
  end

  context '同じ数字のカードが4枚含まれる' do
    it 'bodyに「フォー・オブ・ア・カインド」という記述があること' do
      post :result, params:{hand: "H11 S11 D11 H4 C11"} , session: {}
      expect(response.body).to include('フォー・オブ・ア・カインド')
    end
  end

  context '同じ数字のカード3枚と、別の同じ数字のカード2枚で構成されている' do
    it 'bodyに「フルハウス」という記述があること' do
      post :result, params:{hand: "H2 S2 C4 H4 D2"} , session: {}
      expect(response.body).to include('フルハウス')
    end
  end

  context '同じスートのカード5枚で構成されている' do
    it 'bodyに「フラッシュ」という記述があること' do
      post :result, params:{hand: "H11 H12 H13 H2 H1"} , session: {}
      expect(response.body).to include('フラッシュ')
    end
  end

  context '数字が連続した5枚のカードによって構成されている' do
    it 'bodyに「ストレート」という記述があること' do
      post :result, params:{hand: "H2 S1 C4 C3 C5"} , session: {}
      expect(response.body).to include('ストレート')
    end
    it 'bodyに「ストレート」という記述があること' do
      post :result, params:{hand: "S13 S12 S11 C1 D10"} , session: {}
      expect(response.body).to include('ストレート')
    end
  end

  context '同じ数字の札3枚と数字の違う2枚の札から構成されている' do
    it 'bodyに「スリー・オブ・ア・カインド」という記述があること' do
      post :result, params:{hand: "H2 S2 C2 C4 C12"} , session: {}
      expect(response.body).to include('スリー・オブ・ア・カインド')
    end
  end

  context '同じ数の2枚組を2組と他のカード1枚で構成されている' do
    it 'bodyに「ツーペア」という記述があること' do
      post :result, params:{hand: "H9 S9 C4 H4 D11"} , session: {}
      expect(response.body).to include('ツーペア')
    end
  end

  context '同じ数字の2枚組とそれぞれ異なった数字の札3枚によって構成されている' do
    it 'bodyに「ワンペア」という記述があること' do
      post :result, params:{hand: "H2 S12 C4 H4 D1"} , session: {}
      expect(response.body).to include('ワンペア')
    end
  end

  context '役が1つも成⽴しない' do
    it 'bodyに「ハイカード」という記述があること' do
      post :result, params:{hand: "H9 S1 C4 H8 H2"} , session: {}
      expect(response.body).to include('ハイカード')
    end
  end

end