![InfluxDB 0.8.8](https://img.shields.io/badge/InfluxDB-0.8.8-brightgreen.svg) ![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

docker-influxdb
=====================

Base Docker Image
-----

[debian:wheezy](https://registry.hub.docker.com/_/debian/)

説明
--------------------------

InfluxDB Dockerコンテナイメージです。

[InfluxDBとは？](http://influxdb.com/)  
[Dockerとは？](https://docs.docker.com/)  
[Docker Command Reference](https://docs.docker.com/reference/commandline/cli/)

使用方法
-------------------------

git pull後に

    $ cd docker-influxdb

イメージ作成

    $ docker build -t tanaka0323/influxdb .

起動  
(注:ポート8090と8099は、クラスタリングに使用されます。パブリックに公開はしないで下さい。)

    $ docker run -d -p 8083:8083 -p 8086:8086 --expose 8090 --expose 8099 tanaka0323/influxdb

InfluxDB 初期設定
-------------------------

ブラウザで`http://hostname:8083`へアクセスし各種設定を行って下さい。  
デフォルトの管理者アカウントは`root:root`です。セキュリティーのためにアカウントを変更して下さい。  
代わりにポート`8086'でREATfulなAPIを使用して設定を行うこともできます。

最初のデータベース作成
-------------------------

例として以下の起動オプションで"db1","db2","db3"という名前のデータベースが作成されます。  
区切り文字";"でデータベース名を指定します。

    $ docker run -d -e PRE_CREATE_DB="db1;db2;db3" -p 8083:8083 -p 8086:8086 --expose 8090 --expose 8099 tanaka0323/influxdb

SSL サポート
-------------------------

デフォルトでは、ポート8086がHTTP APIのために使用されています。HTTPS
 APIを使用したい場合は、環境変数に`SSL_SUPPORT=true`と設定して下さい。この場合は、ポート8084のHTTPS APIとポート8086のHTTP APIが使用できます。HTTPS接続のみ許可する場合は、ポート8086を公開しないで下さい。  
  
SSL_CERTを指定した場合は、システムは提供されたSSL証明書を使用します。指定しない場合は、自動的に自己認証の証明書が作成され使用されます。

例として以下コマンドの様に指定できます。

    $ docker run -d -p 8083:8083 -p 8084:8084 -e SSL_SUPPORT="True" -e SSL_CERT="/opt/cert.pem" tanaka0323/influxdb

UDP サポート
-------------------------

UDP_DBを指定した場合は、UDPポート(デフォルトポート4444か`UDP_PORT`で指定します。)をオープンし、指定されたデータベースのイベントを受信します。

    $ docker run -d -p 8083:8083 -p 8086:8086 --expose 8090 --expose 8099 --expose 4444 -e UDP_DB="my_db" tanaka0323/influxdb

クラスタリング
-------------------------

利用可能なボリューム
-------------------------

以下のボリュームが利用可能

    /data  # データベース領域

Docker Composeでの使用方法
-------------------------

[Docker Composeとは](https://docs.docker.com/compose/)  

[設定ファイル記述例](https://bitbucket.org/tanaka0323/compose-examples)

License
-------------------------

The MIT License
Copyright (c) 2015 Daisuke Tanaka

以下に定める条件に従い、本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

上記の著作権表示および本許諾表示を、ソフトウェアのすべての複製または重要な部分に記載するものとします。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。 作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。