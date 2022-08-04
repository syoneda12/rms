class UsersController < ApplicationController
  require 'csv' 
  include UsersHelper
  before_action :logged_in_user
  # authorize_resource class: false
  before_action :set_user, only: [:show, :password, :update_password]
  before_action :set_user_form, only: [:edit, :update]
  before_action :set_skill_hash, only: [:show,:edit, :update]
  before_action :is_edit_user, only: [:edit, :update, :password]
  before_action :is_new_user, only: [:new, :create]
  # before_action :is_subordinate_user, only: [:edit]

  
  # 検索画面表示
  def index
    respond_to do |format|
      @skill_all = Skill.all
      @search_params = user_search_params
      search_result_users = User.search(@search_params)
      tmp_users = []
      if @search_params[:skill].nil? || @search_params[:skill].empty?
        tmp_users = search_result_users
      else  
        tmp_users = []
        search_result_users.each do |user|
          tmp_ary = []
          user.user_skill_links.each do |user_skill_link|
            if @search_params[:skill].include?(user_skill_link.skill.id.to_s)
              tmp_ary.push(user_skill_link.skill.id.to_s)
            end
          end
          if @search_params[:skill].sort == tmp_ary.sort
            tmp_users.push(user)
          end
        end
      end
      result_users = []
      if @search_params.nil? || @search_params.empty?
        result_users = tmp_users
      else
        if @search_params[:subordinate]
          subordinates = LeaderUserLink.where(leader_id:current_user.id)
          tmp_users.each do |user|
            subordinates.each do |subordinate|
              if user.id == subordinate.subordinate_id
                result_users.push(user)
                break
              end
            end
          end
        else
          result_users = tmp_users
        end
      end
      @users = []
      result_users.each do |user|
        if !role_id_system_admin?(user.role_id) && !role_id_admin?(user.role_id)
          @users.push(user)
        end
      end
      format.html do
      end
      format.csv do
        send_users_csv
      end
    end
  end

  # ユーザー詳細表示
  def show
    # @skill_hash = Hash.new { |h,k| h[k] = {} }
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

  # 新規作成(/users/new get)
  def new
    @user = User.new
    @skill_kind_all = SkillKind.new
    @skill_all = Skill.new
    @skill_level_all = SkillLevel.new
  end
  
  # 新規作成(/users post)
  def create
    @user = User.new(user_params)
    if @user.save
      # flash[:notice] = 'Success!' ※１行にまとめられる↓
      # rootパスに遷移
      redirect_to root_path, notice: "#{@user.email} を登録しました。"
    else
      flash[:alert] = 'Save error!'
      #再度ページを表示
      render :new
    end
  end

  def edit
    # @user = Form::User.find(params[:id])
    @skill_kind_all = SkillKind.all
    @skill_all = Skill.all
    @skill_level_all = SkillLevel.all
  end
  
  def update
    # @user = Form::User.find(params[:id])
    @skill_kind_all = SkillKind.all
    @skill_all = Skill.all
    @skill_level_all = SkillLevel.all
    skill_param_hash = Hash.new
    if order_params[:user_skill_links_attributes]
      skill_param_hash = order_params[:user_skill_links_attributes].to_hash
    end
    duplication_array=[]
    skill_param_hash.each{|key, value|
      if value["_destroy"] == 'false'
        duplication_array.push(value["skill_id"])
      end
    }
    if !uniq?(duplication_array)
      flash[:alert] = 'Update error!'
      render :edit
    else
      if @user.update_attributes(order_params)
        redirect_to root_path, notice: "ユーザーを更新しました。"
      else
        flash[:alert] = 'Update error!'
        render :edit
      end
    end

  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to root_url, notice: 'ユーザーを削除しました。'
  end
  
  def password
    # @user = Form::User.find(params[:id])
  end
  
  def update_password
    param = user_params
    if @user.update(password: param[:password], password_confirmation: param[:password_confirmation]) 
      redirect_to root_path, notice: "パスワードを更新しました。"
    else
      flash[:alert] = 'Update error!'
      render :password
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
  
    #formから送られてきたデータを整形
    def user_params
      params.require(:user).permit(:email,:name,:password,:password_confirmation,:role_id,:birthday,:department_id,:gender,:years_of_experience,:address,:closest_station)
    end
    
    #formから送られてきた検索用パラメータを整形
    def user_search_params
      params.fetch(:search, {}).permit(:name, :gender, :birthday_from, :birthday_to, :department_id,:subordinate,skill:[])
    end
    
    def set_user_form
      @user = Form::User.find(params[:id])
    end
    
    
    def order_params
      params
        .require(:form_user)
        .permit(
          Form::User::REGISTRABLE_ATTRIBUTES +
          [user_skill_links_attributes: Form::UserSkillLink::REGISTRABLE_ATTRIBUTES]
        )
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
    
    def is_edit_user
      isEdit = false
      # target_user_id = params[:id].to_i
      target_user = User.find(params[:id])
      if current_user? target_user
        isEdit = true
      end
      if !isEdit
        redirect_to root_url
      end
    end
    
    def is_new_user
      if current_user_system_admin? || current_user_admin?
        isEdit = true
      end
      if !isEdit
        redirect_to root_url
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
    
    def send_users_csv()
    # CSV.generateとは、対象データを自動的にCSV形式に変換してくれるCSVライブラリの一種
    csv_data = CSV.generate do |csv|
      # %w()は、空白で区切って配列を返す
      column_names = %w(email	名前	所属	役職	業界経験年数	誕生日	住所	最寄り駅	性別)
      # csv << column_namesは表の列に入る名前を定義する
      csv << column_names
      # column_valuesに代入するカラム値を定義します。
      @users.each do |user|
        column_values = [
          user.email,
          user.name,
          user.department.name,
          user.role.name,
          user.years_of_experience,
          user.birthday,
          user.address,
          user.closest_station,
          user.gender
                ]
      # csv << column_valueshは表の行に入る値を定義します。
        csv << column_values
      end
    end
    # csv出力のファイル名を定義します。
    send_data(csv_data, filename: "ユーザー一覧.csv")
  end
end
