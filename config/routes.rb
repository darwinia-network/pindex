Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'messages#index'
  resources :messages, only: %i[index]

  get 'message' => 'messages#message', as: :message

  get 'messages/timespent/:op/:number/:unit' => 'messages#timespent',
      as: :messages_timespent

  get 'messages/sent_by/:msgport_from' => 'messages#sent_by'

  get 'messages/:tx_or_hash' => 'messages#show',
      as: :message_by_tx_or_hash,
      constraints: { tx_or_hash: /0x[0-9a-fA-F]{64}/ }

  get 'messages/:from_network(/:to_network)' => 'messages#index', as: :network_messages
end
