class RoleAuthorityLink < ApplicationRecord
  belongs_to :role
  belongs_to :authority
end
