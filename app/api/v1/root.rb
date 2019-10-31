module Root
  class V1 < Grape::API

    version 'v1', using: :path
    format :json

    route :any, '*path' do
      @api_error = []
      @api_error.push({"msg"=>"不正なURLです。"})
      error!({"error": @api_error},404)
    end

    mount Judge::V1

  end
end