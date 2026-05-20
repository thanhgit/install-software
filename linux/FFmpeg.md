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
  * MP4 file using the H.264 codec
  * MP3 file using the AAC codec

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
