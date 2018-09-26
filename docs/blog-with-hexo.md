# Blog with Hexo

## hexo 설치

1. [hexo](https://hexo.io/) 를 설치한다
  1. `sudo apt install nodejs nodejs-legacy npm`
  2. `npm install hexo-cli -g`
2. `hexo init <블로그 폴더>`
3. `<블로그 폴더>/_config.yml` 을 다음과 같이 수정한다

    ```
    title: <블로그 제목>
    subtitle: <부제목>
    description: <설명>
    author: <제작자>
    language: en
    ```

## theme 설정

### theme 설치

1. https://hexo.io/themes/ 에 접속한다
2. 원하는 테마를 선택하고 `<블로그 폴더>/themes/` 에 git clone한다
    - ex: `git clone https://github.com/klugjo/hexo-theme-clean-blog clean-blog`
3. `<블로그 폴더>/_config.yml` 의 `theme` 에 테마 이름을 넣어준다
    - ex: `theme: clean-blog`

### theme 설정 (hexo-theme-clean-blog)

#### 배경 화면 설정

`<블로그 폴더>/themes/<테마 폴더>/_config.yml` 을 다음과 같이 수정한다

- `index_cover: <이미지 위치>`
  - `<테마 폴더>/source/img/` 에 있는 파일을 사용하고 싶을 경우: `index_cover: /img/<파일명>`
  - 인터넷에 있는 이미지를 사용하고 싶은 경우: `index_cover: <파일의 URL>`

## 글 쓰기

- `hexo new post "<글 제목>"`
- 새로운 페이지를 만들 때는 `hexo new page <페이지 제목>`

## 배포

- 글을 다 쓴 후 `hexo generate` 를 하면, `public` 디렉토리에 스태틱 파일을 생성해준다. 이 파일을 nginx로 렌더링 할 수 있다.
- `hexo server` 를 통해 4000번 포트에서 블로그를 띄워 볼 수도 있다. 그러나 종종 변경사항을 반영하지 못하는 버그가 있다.

## let's encrypt를 이용한 ssl 인증서 생성

1. https://certbot.eff.org 에서 nginx, ubuntu 14.04를 선택한다.
2. 선택 후 나오는 페이지 (https://certbot.eff.org/#ubuntutrusty-nginx) 의 내용을 따른다.
    1. `sudo apt-get install software-properties-common`
    2. `sudo add-apt-repository ppa:certbot/certbot`
    3. `sudo apt-get update`
    4. `sudo apt-get install python-certbot-nginx`
3. `sudo certbot --nginx`

## nginx 세팅

1. `vim /etc/nginx/sites-available/<블로그 이름>` 후 다음과 같이 수정한다.

    ```nginx
    server {
      listen 80;
      listen [::]:80;
      server_name {서버이름};
      location / {
        return 301 https://$host$request_uri;
      }
    }
    server {
      listen 443 ssl http2;
      listen [::]:443 ssl http2;
      server_name {서버이름};
      ssl_certificate /etc/{적당한 경로}/fullchain.pem;
      ssl_certificate_key /etc/{적당한 경로}/privkey.pem;
      ssl_trusted_certificate /etc/{적당한 경로}/chain.pem;
      location / {
        root {홈페이지 파일 경로};
        index index.html;
      }
    }
    ```

2. 다음과 같이 심링크를 만든다.

    ```bash
    ln -sf /etc/nginx/sites-available/<블로그 이름> /etc/nginx/sites-enabled/<블로그 이름>
    ```

3. `vim /etc/nginx/ssl.conf` 하여 다음을 추가한다.

    ```nginx
    ssl_protocols TLSv1.2;
    ssl_session_cache shared:SSL:50m;
    ssl_session_timeout 1d;
    ssl_session_tickets off;
    ssl_prefer_server_ciphers on;
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_ciphers '!DHE ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256';
    add_header Strict-Transport-Security max-age=15768000;
    ```

4. `vim /etc/nginx/nginx.conf` 하여 `http` 블록 안에 다음과 같이 `include` 하는 내용을 추가한다.

    ```nginx
    http {
    ...
    include /etc/nginx/*.conf;
    include /etc/nginx/sites-enabled/*;
    }
    ```

5. `sudo nginx -t -c /etc/nginx/nginx.conf` 로 문법을 검사한다.
6. `sudo service nginx reload`
7. `https://www.ssllabs.com/ssltest/` 에서 SSL Server Test를 실행하여, A+ 등급이 나오는지 확인해본다.

## disqus 연동

1. disqus에 가입한다.
2. Configure Disqus for your site에서 url을 추가한다.
3. disqus 연동을 위한 shortname을 복사해서 `<블로그 폴더>/themes/<테마 폴더>/_config.yml` 에 추가한다.

    ```
    disqus_shortname: <shortname>
    ```

### disqus 관리

기본적으로 게스트 댓글 달기가 허용되어 있지 않으므로, 허용으로 바꾼다.

- `disqus.com/admin` -> `Your Site` -> `<url>` -> `Moderate Comments` -> `Site Configuration` 에서 Guest Commenting을 허용한다.

이외에 댓글 사후 승인으로 전환 등의 다양한 옵션이 있다.
