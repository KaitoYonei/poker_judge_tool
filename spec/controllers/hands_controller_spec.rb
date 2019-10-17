require 'rails_helper'

RSpec.describe HandsController, type: :controller do

  feature '入力形式の間違いをはじく' do
    scenario 'フォームに入力する' do
      # トップページを開く
      visit  _path
      # ログインフォームにEmailとパスワードを入力する
      fill_in 'hand', with: 'a s d f g h'
      # ログインボタンをクリックする
      click_on 'Check'
      # ログインに成功したことを検証する
      expect(page).to have_selector 'h2', text: '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
    end
  end

end
