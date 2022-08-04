module SessionsHelper
    # 渡されたユーザーでログインする
    def log_in(user)
        session[:user_id] = user.id
    end
    
    
    # 現在ログイン中のユーザーを返す (いる場合)
    def current_user
        if session[:user_id]
            #@current_user = @current_user || User.find_by(id: session[:user_id])と同じ意味
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end
    
    #受け取ったユーザーがログイン中のユーザーと一致すればtrueを返す
    def current_user?(user)
      user == current_user
    end

    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end
    
    # 現在のユーザーをログアウトする
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
    
    # ログインユーザーがシステム管理者かどうか
    def current_user_system_admin?
        current_user.role_id == 1
    end
    # ログインユーザーが管理者かどうか
    def current_user_admin?
        current_user.role.id == 2
    end
    # ログインユーザーが管理職かどうか
    def current_user_manager?
        current_user.role.id == 3
        # !current_user.role_id.manager?
    end
    # ログインユーザーが一般かどうか
    def current_user_general?
        current_user.role.id == 4
    end
    # ログインユーザーが営業かどうか
    def current_user_view?
        current_user.role.id == 5
    end
    
    def role_id_system_admin?(role_id)
        role_id == 1
    end
    
    def role_id_admin?(role_id)
        role_id == 2
    end
    

    

end
