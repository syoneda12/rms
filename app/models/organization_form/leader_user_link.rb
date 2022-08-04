class Organization_form::LeaderUserLink < LeaderUserLink
    REGISTRABLE_ATTRIBUTES = %i(id leader_id subordinate_id _destroy)
    # belongs_to :leader, class_name: 'User', :foreign_key => 'leader_id'
    # belongs_to :subordinate, class_name: 'User', :foreign_key => 'subordinate_id'
end
