class User
  include Mongoid::Document


  field :email, type: String
  field :name, type: String
  field :password, type: String
  
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :customers, dependent: :destroy

end
