class LeaderUserLink < ApplicationRecord
    validates :leader_id, presence: true
    validates :subordinate_id, presence: true
end
