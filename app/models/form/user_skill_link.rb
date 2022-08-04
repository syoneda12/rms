class Form::UserSkillLink < UserSkillLink
  REGISTRABLE_ATTRIBUTES = %i(id user_id skill_id skill_level_id hide _destroy)

  def selectable_skills
    Skill.all
  end
  
  def selectable_skills_kind_id kind_id
    Skill.where(skill_kind_id: kind_id)
  end 
  
  def selectable_skill_levels
    SkillLevel.all
  end

#   def calculate_order_detail_price
#     self.price = unit_price * quantity
#   rescue
#     self.price = 0
#   end
end