class Authority < ApplicationRecord
    has_many :roles, through: :role_authority_links
    has_many :role_authority_links
end
