class Role < ApplicationRecord
    # has_many :authorities, through: :role_authority_links
    # has_many :role_authority_links
    has_many :users
end
