class SubordinatesController < ApplicationController
  before_action :logged_in_user
  before_action :is_disp_subordinate, only: [:edit,:show]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_skill_hash, only: [:show]
  
  def index
    @search_params = user_search_params
    if current_user_admin?
      @users = User.search(@search_params)
    elsif current_user_manager?
      users = User.search(@search_params)
      subordinates = LeaderUserLink.where(leader_id: current_user.id)
      @users = []
      subordinates.each do |subordinate|
        @users.push(users.find(subordinate.subordinate_user_id))
      end
    end
  end
  
  def show
    @skill_kind_hash = Hash.new
    skill_kind_all = SkillKind.all
    skill_kind_all.each do |skill_kind|
      # @skill_hash =  {skill_kind.name => []}
      @skill_kind_hash[skill_kind.name] = []
    end
    
    @user.user_skill_links.each do |user_skill_link|
      # スキル名
      skill_name = user_skill_link.skill.name
      # スキルレベルID
      skill_level_id = user_skill_link.skill_level.id
      # スキルレベル表示名
      skill_level_name = user_skill_link.skill_level.name
      # スキル種類名
      skill_kind_name = user_skill_link.skill.skill_kind.name
      # byebug
      @skill_kind_hash[skill_kind_name].push({"skill_name" => skill_name, "skill_level_id"=>skill_level_id, "skill_level_name"=>skill_level_name, "hide"=>user_skill_link.hide})
    end
  end
  
  def edit
    
  end
  
  # 編集実行
  def update
    # @question = Question.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path, notice: "ユーザーの所属＆役職を更新しました。"
    else
      flash[:alert] = 'Save error!'
      #再度ページを表示
      render :edit
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
  
    #formから送られてきたデータを整形
    def user_params
      params.require(:user).permit(:role_id,:department_id)
    end
    #formから送られてきた検索用パラメータを整形
    def user_search_params
      params.fetch(:search, {}).permit(:name, :gender, :birthday_from, :birthday_to, :department_id)
    end
    def set_skill_hash
      @skill_kind_hash = Hash.new
      skill_kind_all = SkillKind.all
      skill_kind_all.each do |skill_kind|
        @skill_kind_hash[skill_kind.name] = []
      end
    
      @user.user_skill_links.each do |user_skill_link|
        # スキルID
        skill_id = user_skill_link.skill.id
        # スキル名
        skill_name = user_skill_link.skill.name
        # スキルレベルID
        skill_level_id = user_skill_link.skill_level.id
        # スキルレベル表示名
        skill_level_name = user_skill_link.skill_level.name
        # スキル種類名
        skill_kind_name = user_skill_link.skill.skill_kind.name
        # byebug
        @skill_kind_hash[skill_kind_name].push({"user_skill_link_id"=> user_skill_link.id, "skill_id" => skill_id, "skill_name" => skill_name, "skill_level_id"=>skill_level_id, "skill_level_name"=>skill_level_name, "hide"=>user_skill_link.hide})
      end
    end
    
    def is_disp_subordinate
      isEdit = false
      target_user_id = params[:id].to_i
      # target_user = User.find(params[:id])
      if current_user_admin?
        isEdit = true
      elsif current_user_manager?
        leaderUserLinks = LeaderUserLink.where(leader_id: current_user.id)
        # 部下かどうか
        leaderUserLinks.each do |leaderUserLink|
          if target_user_id == leaderUserLink.subordinate_id
            isEdit = true
          end
        end
      end
      if !isEdit
        redirect_to root_url
      end
    end
end
