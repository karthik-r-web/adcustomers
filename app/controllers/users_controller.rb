class UsersController < ApplicationController
  #skip_before_action :authenticate_user, only: [:create]

  def create
    user = User.new(name: params[:name], email: params[:email], password: params[:password])

    if user.save
      render json: { message: "User created", user: user }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.where(email: params[:email]).first

    if user && user.password == params[:password]
      render json: { message: "Login successful", user: user }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
end
end