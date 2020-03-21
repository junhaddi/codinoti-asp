<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>코디알리미</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link rel="shortcut icon" href="x_FCM_images/favicon.ico" type="image/x-icon" />
  <link rel="icon" href="x_FCM_images/favicon.ico" type="image/x-icon" />
  <!-- 구글 웹폰트 불러오기 -->
  <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap&subset=korean" rel="stylesheet" />
  <!-- manifest 추가 -->
  <link rel="manifest" href="FCM_manifest.json" />
  <!-- iOS 설정 -->
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black" />
  <meta name="apple-mobile-web-app-title" content="codinoti" />
  <link rel="apple-touch-icon" href="X00_images/icons/icon-152x152.png" />
  <!-- 메타데이터 설정 -->
  <meta name="description" content="코디알리미" />
  <meta name="theme-color" content="#ffffff" />
  <script src="https://www.gstatic.com/firebasejs/4.13.0/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/4.13.0/firebase-messaging.js"></script>
  <script>
    // 파이어베이스 프로젝트 ID
    firebase.initializeApp({ messagingSenderId: "188505041022" });
    const messaging = firebase.messaging();

    // 토큰 발급
    messaging
      .requestPermission()
      .then(function () {
        console.log("알림권한 획득");
        return messaging.getToken();
      })
      .then(function (token) {
        tokenElement.innerHtml = token;
        console.log(token);
      })
      .catch(function (err) {
        errorElement.innerHtml = err;
        console.log("토큰 발급 실패", err);
      });

    // 토큰 갱신발급
    messaging.onTokenRefresh(function () {
      messaging
        .getToken()
        .then(function (refreshedToken) {
          console.log("토큰 갱신발급");
          tokenElement.innerHtml = refreshedToken;
	console.log(refreshedToken);
        })
        .catch(function (err) {
          errorElement.innerHtml = err;
          console.log("토큰 갱신발급 실패", err);
        });
    });

    // 푸시알림 처리
    messaging.onMessage(function (payload) {
      addContainer(payload.data);
    });

    // TODO 서버에서 콘텐츠(계시글) 가져오기

    // TODO 서버로 토큰 보내기
  </script>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      padding-top: 75px;
      margin: 10px;
      font-family: "Nanum Gothic", sans-serif;
      background: #d7d8dc;
    }

    header {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      height: 75px;
      padding: 1rem;
      color: white;
      background: #6184dd;
      font-weight: bold;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    header nav {
      overflow: hidden;
    }

    span a {
      color: #ffffff;
      padding: 12px 12px;
      text-decoration: none;
    }

    .feed {
      background-color: #ffffff;
      margin-bottom: 10px;
      padding: 24px;
      box-shadow: 10px 10px 10px grey;
    }

    .date {
      color: #808080;
      margin-bottom: 10px;
    }

    .content {
      color: #6184dd;
      font-weight: bold;
    }
  </style>
</head>

<body>
  <header>
    <h1>코디알리미</h1>
    <nav>
      <span>관리자(추가예정)</span>
      <span id="install" hidden>다운로드</span>
    </nav>
  </header>
  <div class="feed" style="margin-bottom: 30px;">
    <h3>🔥코디알리미 데모 버전입니다🔥</h3>
    <p>소스코드: <a href="https://github.com/junhaddi/codinoti">https://github.com/junhaddi/codinoti</a></p>
    <p>문의: rkdwnsgk05@gmail.com</p>
    <p id="token" style="color:#6184dd; font-weight: bold; word-break: break-all;"></p>
    <p id="error" style="color:red;"></p>
  </div>
  <div class="container"></div>
  <script src="FCM_install.js"></script>
  <script>
    tokenElement = document.getElementById("token");
    errorElement = document.getElementById("error");

    // 서비스 워커 등록
    if ("serviceWorker" in navigator) {
      window.addEventListener("load", () => {
        navigator.serviceWorker
          .register("FCM_ServiceWorker.js")
          .then(reg => {
            console.log("서비스 워커가 등록되었습니다", reg);
          })
          .catch(error => {
            console.log(error);
          });

        navigator.serviceWorker
          .register("firebase-messaging-sw.js")
          .then(reg => {
            console.log("파이어베이스 서비스 워커가 등록되었습니다", reg);
          })
          .catch(error => {
            console.log(error);
          });
      });
    }
  </script>
</body>

</html>