require 'rails_helper'

RSpec.describe HandsController, type: :controller do

  describe 'POST #result'

    render_views


   context do

    before do
      post :result, params:{hand: "ha he df gr ww j"} , session: {}
    end

    it 'bodyに「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」という記述があること' do
      expect(response.body).to include('5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）')
    end
   end


  context do

    before do
      post :result, params:{hand: "hedf gr ww j"} , session: {}
    end

    it 'bodyに「5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）」という記述があること' do
      expect(response.body).to include('5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）')
    end
  end


  context do

    before do
      post :result, params:{hand: "H18 D3 S24 cf H1"} , session: {}
    end

    it 'bodyに「1番目のカード指定文字が不正です。（H18）」という記述があること' do
      expect(response.body).to include('1番目のカード指定文字が不正です。（H18）')
    end
  end

end