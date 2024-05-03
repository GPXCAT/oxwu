# **地牛Wake Up! 台灣地震速報 on Docker !!!**
## **注意本系統只能在 amd64 的架構下執行**

# 使用方式
## 執行 Docker 影像檔(單一)
```bash
docker run --rm -it --privileged --shm-size=512m \
    -p 6901:6901 \
    -e TZ=Asia/Taipei \
    -e VNC_PW=password \
    -e OXWU_NOTIFY_TOKEN="[line notify token here]" \
    -e OXWU_TOWN_NAME="新北市新店區" \
    -e OXWU_TOWN_ID="6500600" \
    -e OXWU_ALERT_INTENSITY="1" \
    -e OXWU_XCLOCK=true \
    -e OXWU_RTMP_URL="rtmp://a.rtmp.youtube.com/live2/XXXXXXXXX" \ # (選用) 直播網址，未帶入則不使用
    -v ./notify.sh:/app/notify.sh \ # (選用) 若要自行指定觸發後的行為可以掛載進去
    jscat/oxwu:latest
```
## 執行 Docker 影像檔(多個)
```yaml
services:
  new-taipei-xindian: &oxwu_template
    image: jscat/oxwu
    privileged: true
    shm_size: 512m
    environment: &environment_template
      TZ: Asia/Taipei
      VNC_PW: password
      OXWU_NOTIFY_TOKEN: "[line notify token here]"
      OXWU_TOWN_NAME: "新北市新店區" # 所在地名稱(用於Notify)
      OXWU_TOWN_ID: 6500600 # 所在地代號
      OXWU_ALERT_INTENSITY: 1 # 預警震度 0~7 級(含以上)
      OXWU_XCLOCK: true # 左上角顯示時鐘
      OXWU_RTMP_URL: "rtmp://a.rtmp.youtube.com/live2/XXXXXXXXX" # (選用) 直播網址，未帶入則不使用
    ports:
      - 6901:6901
    volumes: # (選用) 若要自行指定觸發後的行為可以掛載進去
      - ./notify.sh:/app/notify.sh

  hualien-yuli:
    <<: *oxwu_template
    environment:
      <<: *environment_template
      OXWU_NOTIFY_TOKEN: "[line notify token here]"
      OXWU_TOWN_NAME: "花蓮縣玉里鎮"
      OXWU_TOWN_ID: 1001503
    ports:
      - 6902:6901
```
## 連線進 Docker 內的桌面
透過瀏覽器連線：`https://<IP>:6901`
 - **User** : `kasm_user`
 - **Password**: `password` (或`VNC_PW`所寫的內容)

# 使用效果
## LINE Notify
  ![LINE畫面](/images/Screenshot_20240408-105443.png)

# 相關文件網站
## 地牛Wake Up! 台灣地震速報
> https://eew.earthquake.tw/
## Kasm Workspaces
> https://www.kasmweb.com/
## AppImageLauncher
> https://ubunlog.com/zh-TW/appimagelauncher-integra-appimges-en-ubuntu/
## Building Custom Images
> https://www.kasmweb.com/docs/latest/how_to/building_images.html

# Releases
## 詳見: https://hub.docker.com/r/jscat/oxwu

# 各地區的OXWU_TOWN_ID代號
## 詳見: https://hub.docker.com/r/jscat/oxwu
