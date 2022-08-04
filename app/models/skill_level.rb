class SkillLevel < ApplicationRecord
    has_many :users, through: :user_skill_links
    has_many :skills, through: :user_skill_links
    has_many :user_skill_links
end
