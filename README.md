# docker sabnzbd
This is a Dockerfile to set up "SABnzbd" - (http://sabnzbd.org/)
Build from docker file
```
git clone https://github.com/tssgery/strato-sabnzbd.git
cd strato-sabnzbd
docker build -t sabnzbd .
```
docker run -d -h *your_host_name* -v /*your_config_location*:/config -v /*your_downloads_location*:/data -p 8080:8080 -p 9090:9090 sabnzbd
