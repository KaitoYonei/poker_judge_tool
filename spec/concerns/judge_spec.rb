require 'spec_helper'

RSpec.describe JudgeService do

  let(:test_class) { Struct.new(:hoge) { include JudgeService } }
  let(:target) { test_class.new }

  it "" do
    expect(target.valid).to eq '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
  end

  end