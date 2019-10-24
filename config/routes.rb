Rails.application.routes.draw do
  get "/" => "hands#top"
  post "/" => "hands#result"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
