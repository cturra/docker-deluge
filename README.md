About this container
---
This container runs the Deluge BitTorrent daemon and web ui. More about
Deluge can be found at:

  http://deluge-torrent.org/


Building the container
---
Before building, confirm the `DELUGE_VERSION` environment variable is the
more recent. While not required to build, it will ensure you have the latest
version of Deluge.

With that configurtion complete, the following Docker build command will create
the container image:

```
$ docker build -t cturra/deluge .
```


Running the container:
---
The following example Docker run command mounts three volumes: 1) the Deluge `data`
directory, (2) download location (for both active/completed and (3) torrent file
location.

```
$ docker run --name=deluge -p 8112:8112 -p 53160:53160 \
  -v /data/deluge:/data:rw -v /data/downloads:/data/downloads:rw \
  -v /data/torrent/deluge:/data/torrents:ro -d cturra/deluge
```


Testing the container
---
You should be able to connect to the Deluge web interface with your web browser of choice,
which is listening on 8112/tcp by default.

```
$ curl -I http://localhost:8112
HTTP/1.1 200 OK
Date: Sun, 11 Oct 2015 00:39:44 GMT
Content-Length: 2017
Content-Type: text/html; charset=utf-8
Server: TwistedWeb/13.2.0
```

Update the GeoIP(v6) databases:
---
Deluge ships old version of the (free) GeoIP (v4 and v6) databases. If you'd like to update
those, simple ensure your container name maches the `CONTAINER` variable at the top of the
`update_geoip_db.sh` script and run it. When run, it will download both GeoIP databases from
MaxMind and copy them into your Deluge Docker container.

Here is an example run.

```
$ ./update_geoip_db.sh
 => Downloading IPv4 GeoIP database... done!
 => Downloading IPv6 GeoIP database... done!
 => Extracting and copying databases into container... done!
```
