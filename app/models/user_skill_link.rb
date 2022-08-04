class UserSkillLink < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  belongs_to :skill_level
end
