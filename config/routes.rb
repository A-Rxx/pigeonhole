Pigeonhole::Application.routes.draw do |map|
  
  # Logout should, of course, work without language
  get 'logout' => 'pigeonhole#logout', :as => 'logout'
  
  constraints(:locale => /[a-z]{2}/) do
    scope "(:locale)" do
      
      get 'logout' => 'pigeonhole#logout', :as => 'logout'
      
      # Self-destructive Binary
      resources :binaries, :only => [:new, :create] do
        member do
          post :new # binaries/new has a password login, we want it to accept POST requests.
        end
      end
      get ':id/:key' => 'binaries#show', :as => 'show_binary', :constraints => { :id => /[a-z0-9]{8}/, :key => /[a-zA-Z0-9]{20}/ }
      
      # Self-destructive Tape
      resources :tapes, :only => [:new, :create] do
        member do
          post :new # tapes/new has a password login, we want it to accept POST requests.
          post :download
        end
      end
      get ':id/:key' => 'tapes#show', :as => 'show_tape', :constraints => { :id => /[a-z0-9]{6}/, :key => /[a-zA-Z0-9]{20}/ }
      
      # Message in a safe
      resources :messages, :only => [:new, :create, :destroy] do
        member do
          post :new # messages/new has a password login, we want it to accept POST requests.
          post :download
          post :attachment
        end
      end
      match ':id' => 'messages#show', :as => 'show_message', :constraints => { :id => /[a-z0-9]{6}/ }
      
      root :to => "pigeonhole#index"
      
    end
  end
end
