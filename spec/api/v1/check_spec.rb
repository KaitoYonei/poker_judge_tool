require 'rails_helper'

RSpec.describe "check api", :type => :request do

  context 'URLが不正な場合' do
    it 'リクエストが失敗し404エラーとなること' do
      post :'/api/v1/cards/checks', params:{ "cards":[ "H1 H3 H12 H11 H10","H9 C9 S9 H2 C2","C13 D12 C11 H18 H7"] }
      expect(response.status).to eq 404
    end
  end

  context 'データ形式が不正な場合' do
  it 'リクエストが失敗し400エラーとなること' do
    post :'/api/v1/cards/check', params:{ "card":[ "H1 H3 H12 H11 H10","H9 C9 S9 H2 C2","C13 D12 C11 H18 H7"] }
    expect(response.status).to eq 400
  end
  end

  context '正しいURLに正しい形式のデータが送信された時' do
    before do
      post :'/api/v1/cards/check', params:{ "cards": ["H1 H2 H3 H4 H5","H9 C9 S9 H2 C2","C13 D12 C11 H18 H7"] }
    end
    it 'リクエストが成功すること' do
      expect(response.status).to eq 201
    end
    it '正しい出力結果が返ること' do
      pattern = {
          "result" => [
              {
                  "card" => "H1 H2 H3 H4 H5",
                  "hand" => "ストレートフラッシュ",
                  "best" => true
              },
              {
                  "card" => "H9 C9 S9 H2 C2",
                  "hand" => "フルハウス",
                  "best" => false
              }
          ],
          "error" => [
              {
                  "card" => "C13 D12 C11 H18 H7",
                  "msg" => "4番目のカード指定文字が不正です。(H18)"
              }
          ]
      }
      expect(JSON.parse(response.body)).to eq(pattern)
    end
  end

  context '最も強い手札が2組以上存在するとき' do
    it '正しい出力結果が返ること' do
      post :'/api/v1/cards/check', params:{ "cards": ["H1 H2 H3 H4 H5","C1 C13 C11 C10 C12","C13 D12 C11 H1 H7","D1 H1 D1 H2 H3"] }
      pattern = {
          "result" => [
              {
                  "card" => "H1 H2 H3 H4 H5",
                  "hand" => "ストレートフラッシュ",
                  "best" => true
              },
              {
                  "card" => "C1 C13 C11 C10 C12",
                  "hand" => "ストレートフラッシュ",
                  "best" => true
              },
              {
                  "card" => "C13 D12 C11 H1 H7",
                  "hand" => "ハイカード",
                  "best" => false
              }
          ],
          "error" => [
              {
                  "card" => "D1 H1 D1 H2 H3",
                  "msg" => "カードが重複しています。"
              }
          ]
      }
      expect(JSON.parse(response.body)).to eq(pattern)
    end
  end

end