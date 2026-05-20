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

#### Components
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

#### Convert an uncompressed (chưa nén) audio from a microphone recording to a lossy compressed (nén mất dữ liệu) audio format
```bash
ffmpeg -i uncompressed-stereo.wav \
       -c:a libmp3lame -b:a 128k -ac 2 -ar 44100 \
       compressed.mp3
````

