Rails.application.routes.draw do
  get '/' => 'home#index'
  with_options defaults: { format: :html } do
  end
end
