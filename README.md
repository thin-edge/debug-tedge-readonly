

* How do you run services if the rootfs is mutable? Can the service definitions be put under /data? How is it done today?

* Can new users be added to the base image?


## Moving forward

* Access to hardware without going through AnyDesk...as debugging is almost impossible


```
./dockcross-linux-armv7l-musl -a "-e LDFLAGS='-static'" bash -c "cd build && cmake -DNNG_ENABLE_SQLITE=ON .. && make clean && make"
```

### arm64 / aarch64

```sh
docker run --rm dockcross/linux-arm64-musl > ./dockcross-linux-arm64-musl
chmod +x ./dockcross-linux-arm64-musl

rm -Rf build
mkdir build
./dockcross-linux-arm64-musl -a "-e LDFLAGS='-static'" bash -c "cd build && cmake -DNNG_ENABLE_SQLITE=ON .. && make clean && make"
```


