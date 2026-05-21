# FFmpeg for Multimedia-Processing 
* ffprobe
  > display information about what is contained in a multimedia file
  ```bash
  ffprobe tada.wav
  ```
  
* ffplay
  > play a video file directly
  ```bash
  ffplay solar.mp4
  ```
  ```bash
  ffplay -autoexit -nodisp ding.wav
  ```
  
* ffmpeg
  * MP4 file using the H.264 codec, Xvid codec
  * Audio file using the AAC codec, MP3 codec

#### Install on ubuntu
```bash
sudo apt update
sudo apt install ffmpeg
```

#### Display banner by alias
```bash
alias ffmpeg="ffmpeg -hide_banner"
alias ffplay="ffplay -hide_banner -autoexit"
alias ffprobe="ffprobe -hide_banner"
```

#### Components of FFmpeg
<img width="963" height="619" alt="image" src="https://github.com/user-attachments/assets/bfdaab61-7356-4e02-9dc7-955db56e73c7" />

* Codecs:
  > algorithm used to read or write multimedia content
* Encoders:
  > writing the content
* Decoders:
  > read the written content
* Demuxers
  > is a software component that can read a multimedia input file so that a decoder can work on it
* Muxers
  > writes data to a multimedia output file after it has been processed by an encoder

<img width="905" height="483" alt="image" src="https://github.com/user-attachments/assets/5fbd9e2b-2cd0-4641-bf91-0141d9ee2bfc" />

* Container:
  * có thể có nhiều Stream:
    > stream có thể là audio, video, subtitles, or a file attachment (font files)
    > Ví dụ : audio stream hoặc video stream
  * metadata: như IDv3 tags (such as title, album, and artist)

#### Convert an uncompressed (chưa nén) audio from a microphone recording to a lossy compressed (nén mất dữ liệu) audio format
```bash
ffmpeg -i uncompressed-stereo.wav \
       -c:a libmp3lame -b:a 128k -ac 2 -ar 44100 \
       compressed.mp3
````

#### Extract the audio from mp4
```bash
ffmpeg -i Stopmotion-hot-wheels.mp4 \
       -map 0:1 \
       Stopmotion-hot-wheels.mp3
```

#### Thay thế mp3 mới cho mp4
```bash
ffmpeg -i Stopmotion-hot-wheels.mp4 \
       -i Stopmotion-hot-wheels-fixed.mp3 \
       -map 0:0 -map 1:0 \
       -codec copy \
       Stopmotion-hot-wheels-fixed.mp4
```

#### Tăng âm lượng
```bash
ffmpeg -i videoin.mp4 -filter:a "volume = 30" out30.mp4
```

#### Crop video
* in_h: biến chiều cao của video gốc
* in_w: biến chiều rộng của video gốc
```bash
ffmpeg -i sample.mp4 -filter:v "crop=w=640:h=480:x=100:y=200" out.mp4
```
```bash
ffmpeg -i sample.mp4 -filter:v "crop=w=2/3*in_w:h=2/3*in_h" out.mp4
```

#### Scale video
* Thay đổi độ phân giải video
```bash
ffmpeg -i sample.mp4 -filter:v "scale=w=640:h=480" out.mp4
```
* Ép tỉ lệ %
```bash
ffmpeg -i sample.mp4 -filter:v "scale=w=1/2*in_w:h=1/2*in_h" out.mp4
```
* Ép 1 chiều, chiều còn lại tự động co để giữ nguyên tỉ lệ 
```bash
ffmpeg -i sample.mp4 -filter:v "scale=w=640:h=-1" out.mp4
```





















































