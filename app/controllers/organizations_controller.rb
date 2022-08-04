class OrganizationsController < ApplicationController
  # before_action :set_user, only: [:edit]
  before_action :set_user_form, only: [:edit, :update]
  before_action :get_subordinates, only: [:edit, :update]
  
  
  
  def index
    all_users = User.all
    @leaders = []
    all_users.each do |user|
      # subordinates = LeaderUserLink.where(leader_id:user.id)
      # 誰かの部下じゃない場合
      if !LeaderUserLink.where(subordinate_id:user.id).exists?
        @leaders.push(user_to_hash(user))
      end
    end
  end

  def edit
    @select_users = []
    # システム管理者と自分以外
    tmp_users = User.where.not(role_id: 1).where.not(id: @user.id)
    tmp_users.each do |user|
      # 誰かの部下の場合
      if LeaderUserLink.where(subordinate_id:user.id).where.not(leader_id: @user.id).exists?
        next
      end
      tmp_hash = Hash.new
      tmp_hash[:id] = user.id
      tmp_hash[:name] = user.name + "("+ user.email + ")"
      @select_users.push(tmp_hash)
    end
    # byebug
  end

  def update
    LeaderUserLink.transaction do
      LeaderUserLink.where(leader_id:@user.id).destroy_all
      if params.has_key?(:form_user)
        duplication_array=[]
        order_params.to_hash["leader_leader_user_links"].each do |leaderUserLinkParam|
          duplication_array.push(leaderUserLinkParam[1]["id"])
        end
        if !uniq?(duplication_array)
          flash[:alert] = 'Update error!'
          render :edit
        end
        # byebug
        LeaderUserLink.where(leader_id:@user.id).destroy_all
        order_params.to_hash["leader_leader_user_links"].each do |leaderUserLinkParam|
          leaderUserLink = LeaderUserLink.new
          leaderUserLink.leader_id = @user.id
          leaderUserLink.subordinate_id = leaderUserLinkParam[1]["subordinate_id"]
          leaderUserLink.save
        end
      end
    end
    redirect_to organizations_path, notice: "更新しました。"
    rescue => e
      flash[:alert] = 'Update error!'
      render :edit
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
  
    def set_user_form
      @user = Organization_form::User.find(params[:id])
    end
    
    def user_to_hash(user)
      hash = Hash.new
      hash[:id] = user.id
      hash[:name] = user.name
      # hash[:subordinate] = []
      tmp_subordinate_ary = []
      subordinates = LeaderUserLink.where(leader_id:user.id)
      subordinates.each do |subordinate|
        subordinate_user = User.find(subordinate.subordinate_id)
        tmp_subordinate_ary.push(user_to_hash(subordinate_user))
      end
      hash[:subordinate] = tmp_subordinate_ary
      hash
    end
    
    def order_params
      params
        .require(:form_user)
        .permit(
          [leader_leader_user_links: Organization_form::LeaderUserLink::REGISTRABLE_ATTRIBUTES]
        )
    end
    
    def get_subordinates
      leaderUserLinks = LeaderUserLink.where(leader_id:@user.id)
      @subordinates = []
      leaderUserLinks.each do|leaderUserLink|
        @subordinates.push(User.find(leaderUserLink.subordinate_id))
      end
    end
    
    def uniq?(array)
      uniq_check = {}
      array.each do |v|
        return false if uniq_check.key? v
        uniq_check[v] = true
      end
      return true
    end
end
