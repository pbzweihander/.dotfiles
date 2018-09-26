# Arch Linux Installation Guide

> Disclamer:  
> This guide is for personal use, written in Korean, and not guaranteed for complete and successful installation.  
> Please refer to [arch linux wiki](https://wiki.archlinux.org/index.php/Installation_guide) for actual guide.

- [설치 전 할 일](#%EC%84%A4%EC%B9%98-%EC%A0%84-%ED%95%A0-%EC%9D%BC)
- [설치](#%EC%84%A4%EC%B9%98)
- [시스템 기본 설정](#%EC%8B%9C%EC%8A%A4%ED%85%9C-%EA%B8%B0%EB%B3%B8-%EC%84%A4%EC%A0%95)
- [재부팅](#%EC%9E%AC%EB%B6%80%ED%8C%85)
- [네트워크 설정](#%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC-%EC%84%A4%EC%A0%95)
  - [NetworkManager](#networkmanager)
  - [무선 네트워크](#%EB%AC%B4%EC%84%A0-%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC)
- [부트로더 설치](#%EB%B6%80%ED%8A%B8%EB%A1%9C%EB%8D%94-%EC%84%A4%EC%B9%98)
  - [GRUB](#grub)
  - [systemd-boot](#systemd-boot)
- [GUI 설치](#gui-%EC%84%A4%EC%B9%98)
  - [GNOME](#gnome)
  - [KDE](#kde)
  - [xfce4](#xfce4)
- [기타](#%EA%B8%B0%ED%83%80)
  - [linux-lts 설치](#linux-lts-%EC%84%A4%EC%B9%98)
- [설치 중 문제가 발생했을 때](#%EC%84%A4%EC%B9%98-%EC%A4%91-%EB%AC%B8%EC%A0%9C%EA%B0%80-%EB%B0%9C%EC%83%9D%ED%96%88%EC%9D%84-%EB%95%8C)
  - [PGP 키 에러가 날때](#pgp-%ED%82%A4-%EC%97%90%EB%9F%AC%EA%B0%80-%EB%82%A0%EB%95%8C)

## 설치 전 할 일

1. UEFI로 부팅되었는지 체크

    ```bash
    ls /sys/firmware/efi/efivars
    ```

    -  폴더가 존재한다면 UEFI로 부팅 성공

1. Wifi가 필요하다면 연결

    ```bash
    wifi-menu
    ```

    - `ping google.com` 으로 연결 확인

1. 시계 업데이트

    ```bash
    timedatectl set-ntp true
    ```

1. 디스크 파티셔닝 및 포맷
    1. 파티셔닝

        ```bash
        cgdisk /dev/sda
        ```

        - /dev/sda1: boot 파티션, 1GB, EFI System (EF00)
        - /dev/sda2: swap 파티션, RAM 크기보다 조금 크게, Linux swap (8200)
        - /dev/sda3: root 파티션, Linux filesystem (8300)
    1. 포맷

        ```bash
        mkfs.fat -F32 /dev/sda1
        mkswap /dev/sda2
        mkfs.ext4 /dev/sda3
        ```

    1. 스왑 활성화

        ```bash
        swapon /dev/sda2
        ```

1. 디스크 마운트

    ```bash
    mount /dev/sda3 /mnt
    mkdir /mnt/boot
    mount /dev/sda1 /mnt/boot
    ```

## 설치

1. `/etc/pacman.d/mirrorlist`에서 pacman 한국 미러 추가

    ```
    Server = https://ftp.lanet.kr/pub/archlinux/$repo/os/$arch
    Server = http://ftp.lanet.kr/pub/archlinux/$repo/os/$arch
    Server = http://mirror.premi.st/archlinux/$repo/os/$arch
    ```

    - 가끔 미러의 상태가 변할 때가 있으니 [Arch Linux Mirror Status](https://www.archlinux.org/mirrors/status/) 참고해서 추가하자
1. 기본 패키지 설치

    ```bash
    pacstrap /mnt base base-devel
    ```

## 시스템 기본 설정

1. fstab 파일 생성

    ```bash
    genfstab -U /mnt >> /mnt/etc/fstab
    ```

1. 설치한 리눅스로 chroot

    ```bash
    arch-chroot /mnt
    ```

1. 타임존 설정

    ```bash
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
    hwclock --systohc --utc
    ```

1. 로케일 생성
    1. `/etc/locale.gen`에서 로케일을 uncomment
        - `en_US.UTF-8 UTF-8`
        - `ko_KR.UTF-8 UTF-8`
    1. `locale-gen`으로 로케일 생성
    1. 사용할 로케일을 `/etc/locale.conf`에 추가

        ```bash
        echo LANG=en_US.UTF-8 > /etc/locale.conf
        ```

1. 네트워크 설정
    1. `/etc/hostname`에서 호스트네임 설정
    1. `/etc/hosts`에서 설정한 호스트네임 추가

        ```
        127.0.0.1	localhost
        ::1		localhost
        127.0.1.1	HOSTNAME.localdomain	HOSTNAME
        ```

    1. [네트워크 설정](#네트워크-설정) 참고
1. 유저 생성
    1. 새 유저 생성

        ```bash
        useradd -m -G sudo -s /bin/bash USERNAME
        passwd USERNAME
        ```

    1. `EDITOR=nano visudo` 후 `%sudo ALL=(ALL) ALL`를 uncomment
    1. root 잠그기

        ```bash
        passwd root -dl
        ```

1. 부트로더 설치
    - [부트로더 설치](#부트로더-설치) 참고
1. GUI 설치
    - [GUI 설치](#GUI-설치) 참고

## 재부팅

```bash
exit
umount -R /mnt/boot
umount -R /mnt
reboot
```

## 네트워크 설정

[Arch Wiki/Network Configuration](https://wiki.archlinux.org/index.php/Network_configuration)

DHCP를 세팅하거나, NetworkManager를 설치하면 된다.

GUI 환경을 세팅할거면 얌전히 NetworkManager를 설치하자.

### NetworkManager

```bash
pacman -S networkmanager
systemctl enable NetworkManager.service
```

시스템 트레이가 필요하면 `network-manager-applet` 설치

### 무선 네트워크

[Arch Wiki/Wireless Network Configuration](https://wiki.archlinux.org/index.php/Wireless_network_configuration) 참조

`iw`, `wpa_supplicant`, `gnome-keyring`을 설치하면 대충 된다

## 부트로더 설치

[Arch Wiki/Category:Boot Loaders](https://wiki.archlinux.org/index.php/Category:Boot_loaders)

intel 또는 AMD CPU 사용자라면 [microcode](https://wiki.archlinux.org/index.php/Microcode)를 설치해야한다.

- intel이라면 `intel-ucode`
- AMD라면 `amd-ucode`

### GRUB

1. `grub`과 `efibootmgr` 설치
1. 부트로더 설치

    ```bash
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub --recheck
    ```

1. `/etc/default/grub`에서 설정
    - `GRUB_TIMEOUT` : `1`
1. 설정파일 생성

    ```bash
    grub-mkconfig -o /boot/grub/grub.cfg
    ```

### systemd-boot

1. 부트로더 설치

    ```bash
    bootctl --path=/boot install
    ```

1. root 파티션의 PARTUUID를 확인

    ```bash
    blkid -s PARTUUID -o value /dev/sda3
    ```

    - 위 줄을 실행하면 root 파티션의 PARTUUID가 출력된다
1. `/boot/loader/entries/arch.conf` 파일을 생성

    ```
    title Arch Linux
    linux /vmlinuz-linux
    initrd /initramfs-linux.img
    options root=PARTUUID=(아까 읽은 PARTUUID) rw
    ```

    > ```bash
    > blkid -s PARTUUID -o value /dev/sda3 > /boot/loader/entries/arch.conf
    > ```
    >
    > 위 처럼 실행한 후 수정하면 편하다

1. `/boot/loader/loader.conf`를 수정

    ```
    default arch
    timeout 1
    editor 0
    ```

## GUI 설치

아치 위키를 참조해서 그래픽카드 드라이버 설치. 인텔이면 `mesa`, `xf86-video-intel`을 설치하면 대충 된다.

터치패드가 있다면 `xf86-input-synaptics` 설치

### GNOME

아주 쉽다.

```bash
pacman -S gnome
systemctl enable gdm.service
```

### KDE

1. X Server 설치

    ```bash
    pacman -S xorg-server xorg-server-utils
    ```

1. `plasma` 설치
1. plasma에 기본 프로그램이 하나도 없기 때문에 `konsole` 등의 기본 프로그램을 꼭 설치
1. 언어팩 설치

    ```bash
    pacman -S kde-l10n-ko
    ```

1. 디스플레이 매니저 활성화

    ```bash
    systemctl enable sddm.service
    ```

### xfce4

1. X Server 설치

    ```bash
    pacman -S xorg-server xorg-server-utils
    ```

1. `xfce4` 설치
1. 디스플레이 매니저를 설치해야한다. 만만한 GDM을 써보자

    ```bash
    pacman -S gdm
    systemctl enable gdm.service
    ```

## 기타

### linux-lts 설치

`linux` 커널이 가끔 불안정할 때가 있어서 `linux-lts`를 선호

1. `linux-lts` 패키지 설치
1. 부트로더가 linux-lts로 부팅하도록 설정
    - GRUB
      1. `/etc/default/grub` 수정
          - `GRUB_DISABLE_SUBMENU` : `y`
          - linux와 lts 중 선택하여 부팅하고, 이전 선택을 기억하고 싶다면
            - `GRUB_TIMEOUT` : 충분히 늘리기 (예: `4`)
            - `GRUB_DEFAULT` : `saved`
            - `GRUB_SAVEDEFAULT` : `true`
          - lts로만 부팅하고 싶다면
            - lts로 부팅하고 `linux`를 삭제
            - 또는 `GRUB_DEFAULT`를 lts로 바꾸기
      1. 설정파일 생성

          ```bash
          grub-mkconfig -o /boot/grub/grub.cfg
          ```

    - systemd-boot
      1. `/boot/loader/entries/arch-lts.conf` 파일 생성

          ```
          title Arch Linux LTS
          linux /vmlinuz-linux-lts
          initrd /initramfs-linux-lts.img
          options root=PARTUUID=(root 파티션의 PARTUUID) rw
          ```

      1. 기본으로 부팅하고 싶다면 `/boot/loader/loader.conf` 수정

          ```
          default arch-lts
          
          ...
          ```

## 설치 중 문제가 발생했을 때

### PGP 키 에러가 날때

`archlinux-keyring`, `gnome-keyring`을 재설치하고 다시 해보자
