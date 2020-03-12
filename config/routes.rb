Rails.application.routes.draw do
  root 'api/v1/weathers#index'
  namespace 'api' do
    namespace 'v1' do
      resources :weathers
    end
  end
end
