Rails.application.routes.draw do
  get "/" => "home#top"
  get "result" => "home#top"
  post "result" => "home#result"
  get "judge" => "home#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
