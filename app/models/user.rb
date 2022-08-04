class User < ApplicationRecord
  REGISTRABLE_ATTRIBUTES = %i()
  enum gender: { 男: 0, 女: 1 }
  
  has_secure_password
  
  validates :name, presence: true #追記
  validates :role_id, presence: true #追記
  validates :gender, presence: true #追記
  validates :department_id, presence: true
  
  belongs_to :role
  belongs_to :department
  
  has_many :skills, through: :user_skill_links
  has_many :slill_levels, through: :user_skill_links
  has_many :user_skill_links, dependent: :destroy
  
  scope :search, -> (search_params) do
    return if search_params.blank?

    name_like(search_params[:name])
      .gender_is(search_params[:gender])
      .birthday_from(search_params[:birthday_from])
      .birthday_to(search_params[:birthday_to])
      .department_is(search_params[:department_id])
  end
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :gender_is, -> (gender) { where(gender: gender) if gender.present? }
  scope :birthday_from, -> (from) { where('? <= birthday', from) if from.present? }
  scope :birthday_to, -> (to) { where('birthday <= ?', to) if to.present? }
  scope :department_is, -> (department_id) { where(department_id: department_id) if department_id.present? }


  accepts_nested_attributes_for :user_skill_links, allow_destroy: true
end
