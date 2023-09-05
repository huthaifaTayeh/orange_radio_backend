class AdminPagesController < ApplicationController
  skip_after_action :verify_authenticity_token, raise: false
  before_action :authenticate_devise_api_token!, only: [:campaigns]
  before_action :verify_admin
  def home; end

  def users
    render json: {
      users: User.employee.order(created_at: :desc)
    }, status: :ok
  end

  def campaigns; end

  private

  def verify_admin
    render json: {message: "no token where provided, please provide a valid token"} unless
    render json: {message: "unauthorized user"}, status: :unauthorized unless current_devise_api_token.resource_owner.admin?
  end
end
