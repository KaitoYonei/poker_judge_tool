require 'rails_helper'

RSpec.describe API::V1::Judges, type: :request do
  it '新しいpostを作成する' do
    valid_params = { "cards":[ "H1 Hd3 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ] }

    #データが作成されている事を確認
    expect { post '/api/v1/judge', params: { post: valid_params } }.to change(Post, :count).by(+1)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
  end
end