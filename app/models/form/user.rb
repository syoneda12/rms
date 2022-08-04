class Form::User < User
  REGISTRABLE_ATTRIBUTES = %i(name birthday gender years_of_experience address closest_station)
  has_many :user_skill_links, class_name: 'Form::UserSkillLink'

  after_initialize { user_skill_links.build unless self.persisted? || user_skill_links.present? }
#   before_validation :calculate_order_price

#   def selectable_corporations
#     Corporation.all
#   end

  private

#   def calculate_order_price
#     user_skill_links.each(&:calculate_order_detail_price)
#     self.price = order_details.map(&:price).sum
#   end
end