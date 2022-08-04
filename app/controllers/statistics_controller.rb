class StatisticsController < ApplicationController
  def index
    # byebug
    @search_params = search_params
    set_statistics_hash
  end
  
  private
    def set_statistics_hash
      all_user = User.all
      @statistics_hash = Hash.new
      skill_kind_all = SkillKind.all
      skill_kind_all.each do |skill_kind|
        @statistics_hash[skill_kind.name] = []
      end
      
      all_user.each do |user|
        user.user_skill_links.each do |user_skill_link|
          # スキルID
          skill_id = user_skill_link.skill.id
          # スキル名
          skill_name = user_skill_link.skill.name
          # スキルレベルID
          skill_level_id = user_skill_link.skill_level.id
          if @search_params.present? && !@search_params.include?(skill_level_id.to_s)
            next
          end
          # スキルレベル表示名
          skill_level_name = user_skill_link.skill_level.name
          # スキル種類名
          skill_kind_name = user_skill_link.skill.skill_kind.name
          if @statistics_hash.key?(skill_kind_name)
            skill_kind_hash_array = @statistics_hash[skill_kind_name]
            is_skill = false
            # for i in skill_kind_hash_array do
            # skill_kind_hash_array = skill_kind_hash_array.map do |skill_kind_hash |
            skill_kind_hash_array.size.times do |i|
              # 
              skill_kind_hash = skill_kind_hash_array[i]
              if skill_kind_hash.nil?
                next
              end
              if !skill_kind_hash.key?("skill_id")
                next
              end
              # byebug
              if skill_kind_hash["skill_id"] == skill_id
                skill_kind_hash["number"] = skill_kind_hash["number"] + 1
                skill_kind_hash_array[i] = skill_kind_hash
                is_skill = true
                break
              end
            end
            if !is_skill
              skill_kind_hash_array.push({"skill_id" => skill_id, "skill_name" => skill_name, "number" => 1})
            end
            @statistics_hash[skill_kind_name] = skill_kind_hash_array
          end
        end
      end
      # number降順でソート
      skill_kind_all.each do |skill_kind|
        @statistics_hash[skill_kind.name] = @statistics_hash[skill_kind.name].sort_by { |a| a["number"] }.reverse
        # byebug
      end
      # byebug
    end
    
      #formから送られてきた検索用パラメータを整形
    def search_params
      # params.fetch(:search, {}).permit(:skill_level_id)
      # byebug
      params.fetch(:search, {}).fetch(:skill_level_id, {})
    end
end
