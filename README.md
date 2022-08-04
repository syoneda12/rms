# rms - 学習用WEBアプリケーション(Ruby on Rails)
  
### 概要
ユーザースキルを管理するシステムをRoRで作成した。   
DBはMySql  

### 学習内容(キーワード)
- Rails の基礎(controllers、models、views、helpers)
- 認証(セッション、パスワードのハッシュ化)
- CRUD
- 複数条件 DB 検索
- 中間テーブル
- csv 出力
- ロールでの画面制御
- Rails の設定(routes、gem、require、production)  

### 画面一覧
- ログイン
- ホーム
- 統計
- ユーザー検索
- ユーザー詳細
- 部下編集(所属・役職)
- 配置図
- 配置変更
- ユーザー追加
- マイアカウント編集
- パスワード変更

### ロール一覧
ユーザーには必ずロールが設定される
- システム管理者(system_admin)
- 管理者(admin)
- 管理職(manager)
- 一般(general)
- 営業(view)

### ER図
![ER](https://user-images.githubusercontent.com/62499574/182854209-40750ed5-4af0-4a40-88da-d93b804c60f6.png)
