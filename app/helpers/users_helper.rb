module UsersHelper
    def is_subordinate(user_id)
        ret = false
        if current_user_admin?
            ret = true
        elsif current_user_manager?
            subordinates = LeaderUserLink.where(leader_id: current_user.id)
            subordinates.each do |subordinate|
                if user_id == subordinate.subordinate_id
                    ret = true
                end
            end
        end
        ret
    end
end
