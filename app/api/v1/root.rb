module Root
  class V1 < Grape::API
    #ex) http://localhost:3000/api/v1
    version 'v1', using: :path
    format :json

    #content_type :json, 'application/json'

    # 404NotFoundの扱い


    mount Judge::V1
  end
end