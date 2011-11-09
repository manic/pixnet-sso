Rails.application.routes.draw do
  match "/api/checklogin" => "pixauth#index", :as => :api_checklogin
end
