# djangotmp : Webアプリ作成用Djangoテンプレート
## 概要・特徴
django Webアプリケーションの勉強用、サイト構築テンプレート。
- debian-slim版pythonイメージをベース
    - djangoライブラリ
    - bootstrap
    - nodejs (sass , typescript)
    - ビルドに使用した余計なツールやライブラリを極力削除して軽量なイメージを目指す
- WEBサイトテンプレートを作成するstartupスクリプト
    - プロジェクトが存在しなければばある程度使えるレベルまで自動生成
        - プロジェクト初期化
        - settings.pyを編集（ログ出力やbootstrapなど追加ライブラリ使用）
    - スタティック領域の更新・コンパイラ常駐機動
        - bootstrap関連ファイルのコピー/初期編集
        - sass , typescript 常駐コンパイラ起動
## 使い方
- .envファイルを作成し環境変数設定（この二つがないと起動しない）
    - DJANGO_NAME : プロジェクト名
    - DJANGO_SPAPP : シングルページアプリケーション名
- ビルド＆起動
    - $ docker-compose up -d

