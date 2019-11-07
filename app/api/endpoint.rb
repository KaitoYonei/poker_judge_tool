module Endpoint
  class API < Grape::API

    prefix "api"

    format :json

    mount Root::V1
  end
end