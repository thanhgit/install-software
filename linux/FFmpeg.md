# FFmpeg for Multimedia-Processing 
* ffprobe
  > display information about what is contained in a multimedia file
  ```bash
  ffprobe tada.wav
  ```
  
* ffplay
* ffmpeg.

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
