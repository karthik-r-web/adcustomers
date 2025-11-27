Rails.application.routes.draw do
    post "login", to: "users#login"
    resources :users
    get "/customers/today_customers",            to: "customers#today_customers"
    get "/customers/previous_day_customers",        to: "customers#previous_day_customers" 
    get "/customers/one_week_customers",         to: "customers#one_week_customers"
    get "/customers/one_month_customer",        to: "customers#one_month_customer"
    get "/customers/one_year_customer",         to: "customers#one_year_customer"
     get "/customers/today_purchase",         to: "customers#today_purchase"
    resources :customers
    resources :customers do
    # Member route for status update
    put "status", on: :member
  end
end
