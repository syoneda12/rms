class Skill < ApplicationRecord
    has_many :users, through: :user_skill_links
    has_many :slill_levels, through: :user_skill_links
    has_many :user_skill_links
    
    belongs_to :skill_kind
end
