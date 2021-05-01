class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  extend FriendlyId
  friendly_id :eng_name, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :appointments
  has_many :events, through: :appointments

  validates :eng_name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 50 }

  scope :filtered, ->(query_params) { where("eng_name ILIKE ?", "%#{query_params[:search_item]}%") }


  
       def generate_first_name   
		language.chars.first.upcase + gender.chars.first.upcase + locality.upcase + " "
       end

       def generate_last_name
              eng_name.split.map(&:chr).join.upcase
       end

end
