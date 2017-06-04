# pacman conflicting files

```
error: failed to commit transaction (conflicting files)
ca-certificates-utils: /etc/ssl/certs/ca-certificates.crt exists in filesystem
Errors occurred, no packages were upgraded.
```

해결법:

```bash
sudo pacman -Syuw
sudo rm /etc/ssl/certs/ca-certificates.crt
sudo pacman -Su
```

