Rails.application.routes.draw do
  get 'applications/:token', to: 'application#get_by_uuid'
  post 'applications', to: 'application#create'
  put 'applications/:token', to: 'application#update_by_uuid'
  get 'applications', to: 'application#index'

  post 'chat', to: 'chat#create'

  post 'message', to: 'message#create'
  get 'message/applications/:app_token/chat/:chat_number', to: 'message#get_all_messages_by_chat_api'
  get 'message/applications/:app_token/chats', to: 'message#get_all_messages_for_application_api'
  post 'applications/:app_token/chat/:chat_number/search-message', to: 'message#search_message_by_body_api'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
