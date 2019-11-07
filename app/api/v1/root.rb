module Root
  class V1 < Grape::API

    version 'v1', using: :path
    format :json

    rescue_from Grape::Exceptions::Base do
      @api_error = []
      @api_error.push({"msg"=>"不正なリクエストです。"})
      error!({"error": @api_error},400)
    end

    route :any, '*path' do
      @api_error = []
      @api_error.push({"msg"=>"不正なURLです。"})
      error!({"error": @api_error},404)
    end

    rescue_from :all do |e|
      error!({error: e.message, backtrace: e.backtrace[0]}, 500)
    end

    mount Judge::V1

  end
end