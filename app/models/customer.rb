class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,        type: String
  field :email,       type: String
  field :phone,       type: String
  field :address,     type: String
  field :product,     type: String
  field :amount,      type: Float, default: 0.0  
  field :status,      type: String, default: "new"


  belongs_to :user

  # Validations
  validates :name, presence: true
  validates :phone, presence: true, 
                    uniqueness: { message: "number already exists for this customer" },
                    format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
     validates :status, inclusion: { in: %w[new active inactive repair closed], message: "%{value} is not a valid status" }                 
   
end
