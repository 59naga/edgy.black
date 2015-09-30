> [edgy.black](http://edgy.black/)

![2015-09-30 16 29 56](https://cloud.githubusercontent.com/assets/1548478/10187062/8ce96de2-6790-11e5-9e77-a147c6f98077.png)

# TODO
## やばいやつ
* スラム街の整備（ドキュメントをしっかり書く）

## オレオレ要望（上ほど優先）
* SNS機能が充実していない不具合
* 遊び心の不足
* マイページ is 伽藍堂
* トップにギミックを足したい
* 日付叩いたらパーマリンク出して欲しい
* ライセンス（転載禁止etc…過去デザイン参照）

* スライドショーが欲しい
* かっこいいアラートメッセージ（swalはborder-radius使っててEDGEじゃない）
* ヒストリー（投稿履歴・閲覧数○○オーバーなど）
* けんさくけっか・マイページさくひん一覧（文字情報多めの画像検索ページを作る）
* ランキング

## 下げられた優先度（めんどくさい）
* ng-messagesのインストールと実装
* クローラー
  * 404返しちゃまずい所が結構ある

* 連投できるけど大丈夫？

* テストをていねいに書く（動かなくなったテスト）
  * 結構変わってる

> 昔作ったデザイン
> https://dl.dropboxusercontent.com/u/22608895/edgy/index.html

# Engine
$ nodebrew use v0.12.0

## Setup docker for OSX
```bash
$ brew install boot2docker
$ boot2docker init # may sudo
$ boot2docker up # may sudo
```

## Setup redis by docker
```bash
$ docker run -d --name edgy.redis -p 6379:6379 redis
# edgy.redis
```

## Setup mysql by docker
```bash
$ docker run --name edgy.black -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql
# edgy.black

$ docker exec -it edgy.black mysql -u root -p
# Type: root

mysql $ create database edgy_test;
# Query OK, 1 row affected (0.00 sec)

mysql $ SET PASSWORD = PASSWORD('');
# Query OK, 0 rows affected (0.00 sec);

mysql $ exit
# Bye
```

## Setup ./server/env_secret.coffee
```coffee
# Dependencies
env= process.env

# Setup environment
env.consumerKey= ""
env.consumerSecret= ""
env.accessToken= ""
env.accessSecret= ""

module.exports= env
```

## Setuped
```bash
$ docker ps -a
# ... IMAGE        ... PORTS                  NAMES
# ... redis:3      ... 0.0.0.0:6379->6379/tcp edgy.redis
# ... mysql:latest ... 0.0.0.0:3306->3306/tcp edgy.black
```

## Setup password for test
```bash
# Set env a twitter login password
$ echo -n 'rawpassword' | base64
# ######

$ vim ~/.bash_profile
# export EDGY_BLACK_TWITTER=######
$ source ~/.bash_profile

$ npm test
```

>
  * https://registry.hub.docker.com/_/mysql/
  * https://registry.hub.docker.com/_/redis/
  * https://docs.saucelabs.com/ci-integrations/travis-ci/
