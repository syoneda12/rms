class Organization_form::User < User
  REGISTRABLE_ATTRIBUTES = %i()
  # has_many :leader_leader_user_links, class_name: 'Organization_form::LeaderUserLink', :foreign_key => 'leader_id', dependent: :destroy
  # has_many :subordinate_leader_user_links, class_name: 'Organization_form::LeaderUserLink', :foreign_key => 'subordinate_id', dependent: :destroy

  # after_initialize { leader_user_links.build unless self.persisted? || leader_user_links.present? }
  # accepts_nested_attributes_for :leader_leader_user_links, allow_destroy: true
  # accepts_nested_attributes_for :subordinate_leader_user_links, allow_destroy: true
end