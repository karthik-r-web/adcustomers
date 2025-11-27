class CustomersController < ApplicationController
  # if you want to protect it, remove this:
  before_action :set_user

  def index
    customers = @user.customers.all
    render json: customers
  end

  def show
    customer = @user.customers.find(params[:id])
    render json: customer
  end

  def create
    customer = Customer.new(customer_params)
    customer.user = @user
    if customer.save
      render json: { message: "Customer created", customer: customer }, status: :created
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    customer = @user.customers.find(params[:id])

    if customer.update(customer_params)
      render json: { message: "Customer updated", customer: customer }
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def today_customers
    customers =@user.customers.where(:created_at.gte => Time.zone.today.beginning_of_day)
    render json:{ customers: customers, total_today_customers:customers.count}


  end

  def previous_day_customers
    start_time = 1.day.ago.beginning_of_day
    end_time   = 1.day.ago.end_of_day
    customers = @user.customers.where(:created_at.gte => start_time, :created_at.lte => end_time)
    render json:{ customers: customers, total_previous_day_customers:customers.count}

  end

  def one_week_customers
     customers = @user.customers.where(:created_at.gte => 1.week.ago.beginning_of_day)
      render json:{ customers: customers, total_one_week_customers:customers.count}

  end

  def one_month_customer
  customers = @user.customers.where(:created_at.gte => 1.month.ago.beginning_of_day)
    render json:{ customers: customers, total_one_month_customer:customers.count}
end

  def one_year_customer
  customers = @user.customers.where(:created_at.gte => 1.year.ago.beginning_of_day)
    render json:{ customers: customers, total_one_year_customer:customers.count}
end

  def today_purchase
    customers =@user.customers.where(:created_at.gte => Time.zone.today.beginning_of_day)
   total_amount = customers.sum(:amount)  # Mongoid sum
   render json: { total_amount_today: total_amount }
  end

# PATCH /customers/:id/status
  def status
    customer = @user.customers.find(params[:id])

    if params[:status].present? && customer.update(status: params[:status])
      render json: { message: "Customer status updated", customer: customer }
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

#   def destroy
#     customer = Customer.find(params[:id])
#     customer.destroy
#     render json: { message: "Customer deleted" }
#   end

  private

  def customer_params
    params.permit(:name, :email, :phone, :address, :company, :amount, :status)
  end

  def set_user
   @user = User.where(email:params[:user_email]).first
  end

end
