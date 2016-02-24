Rails.application.routes.draw do

  get 'guest' => 'pages#guest', as: :guest
  get 'activity' => 'pages#index', as: :activity
  get 'help' => 'pages#help', as: :help


  devise_for :users
  resources :mailboxes, only: [:index]
  resources :mailboxer_conversations do
    member do
      post :reply
      post :restore
    end

    collection do 
      delete :empty_trash
    end
  end

  get 'mailbox/inbox' => 'mailboxes#inbox', as: :mailbox_inbox
  get 'mailbox/sent' => 'mailboxes#sent', as: :mailbox_sent
  get 'mailbox/trash' => 'mailboxes#trash', as: :mailbox_trash

  resources :comments
  resources :image_posts do 
    resources :comments,only: [:create]
  end

  resources :text_posts do 
    resources :comments,only: [:create]
  end
  
  resources :posts, only: [:index, :show]

  resources :users do 
    resources :profiles
    resources :photos
    
    member do 
      post :follow
      delete :unfollow
    end
  end
  resources :photos

  root 'pages#guest'
end
