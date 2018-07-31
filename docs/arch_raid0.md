# Arch with RAID 0

RAID 0로 Arch Linux 설치하기

2개의 디스크가 각각 `sda`, `sdb` 라고 가정하고,  
`sda1` 을 boot, `sdb1` 을 swap으로 설정, 디스크의 남은 공간 `sda2`, `sdb2` 를 RAID 0로 묶는다.

## 부팅미디어에서 할 일

1. UEFI로 부팅했는지 체크
    ```bash
    ls /sys/firmware/efi/efivars # 폴더가 존재한다면 UEFI로 부팅 성공
    ```
1. 시계 업데이트
    ```bash
    timedatectl set-ntp true # 시계 업데이트
    ```
1. 디스크 파티셔닝
    ```bash
    cgdisk /dev/sda
    ```
    - /dev/sda1 : 1GB (넉넉잡아 2GB도 무방할 듯), EFI System (EF00)
    - /dev/sda2 : Linux filesystem (8300, default)
    ```bash
    cgdisk /dev/sdb
    ```
    - /dev/sdb1 : depends on RAM, Linux swap (8200)
    - /dev/sdb2 : Linux filesystem (8300, default)
1. RAID 0로 묶기
    ```bash
    modprobe raid0
    mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sda2 /dev/sdb2
    ```
1. 파티션 포맷 및 마운트
    ```bash
    mkfs.fat -F32 /dev/sda1
    mkswap /dev/sdb1
    mkfs.ext4 /dev/md0

    mount /dev/md0 /mnt
    mkdir /mnt/boot
    mount /dev/sda1 /mnt/boot
    swapon /dev/sdb1
    ```
1. 기본 패키지 설치
    1. 미러 우선순위 변경
        ```bash
        nano /etc/pacman.d/mirrorlist
        ```
        - 다음 두 줄을 추가
          - `Server = http://mirror.premi.st/archlinux/$repo/os/$arch`
          - `Server = http://ftp.kaist.ac.kr/ArchLinux/$repo/os/$arch`
    1. 설치
        ```bash
        pacstrap /mnt base base-devel
        ```
1. mdadm 설정
    1. 설정 파일 생성
        ```bash
        mdadm --examine --scan > /mnet/etc/dadm.conf
        ```
    1. rc.conf 수정
        ```bash
        nano /mnt/etc/rc.conf
        ```
        - `MODULES=(raid0)`
    1. mkinitcpio.conf 수정
        ```bash
        nano /mnt/etc/mkinitcpio.conf
        ```
        - `MODULES=(dm_mod)`
        - `HOOKS= ...` 뒤에, `filesystems` 앞에 `mdadm` 추가
          - 예: `HOOKS=(base udev autodetect modconf block mdadm filesystems keyboard fsck)`
1. fstab 생성
    ```bash
    genfstab -U /mnt >> /mnt/etc/fstab
    arch-chroot /mnt
    ```
1. chroot
    ```bash
    arch-chroot /mnt
    ```

## 설치 직 후 할 일

1.  Timezone 설정
    ```bash
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
    hwclock --systohc --utc
    ```
1.  Locale 설정
    ```bash
    nano /etc/locale.gen
    ```
    - 필요한 로케일을 uncommment
      - `en_US.UTF-8 UTF-8`
      - `ko_KR.UTF-8 UTF-8`
    ```bash
    locale-gen
    echo LANG=en_US.UTF-8 > /etc/locale.conf
    ```
1. 컴퓨터 이름 설정
    ```bash
    echo '{PC_NAME}' > /etc/hostname
    nano /etc/hosts
    ```
    - `127.0.1.1 {PC_NAME}.localdomain {PC_NAME}` 추가
1. 네트워크 설정
    1. 네트워크 인터페이스 이름 확인
        ```bash
        ip link
        ```
    1. 인터페이스 활성화
        ```bash
        ip link set {interface} up
        ```
    1. DHCP를 설정하거나, NetworkManager를 설치하자
1. 유저 생성
    ```bash
    useradd -m -G sudo -s /bin/bash {username}
    passwd {username}
    passwd root -dl
    ```
1. sudo 설치
    ```bash
    pacman -S sudo
    EDITOR=nano visudo
    ```
    - `%sudo ALL=(ALL) ALL` 라고 적혀있는 줄을 uncomment
1. 부트 매니저 grub 설치
    ```bash
    pacman -S grub
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub --recheck
    grub-mkconfig -o /boot/grub/grub.cfg
    ```

## GUI 설치

### 사전 준비

1. 그래픽 카드 드라이버 설치
    ```bash
    pacman -S mesa xf86-video-intel
    ```
1. 네트워크 매니저 설치
    ```bash
    pacman -S network-manager-applet networkmanager
    systemctl enable NetworkManager.service
    ```
1. 무선 네트워크가 필요하다면
    ```bash
    pacman -S iw wpa_supplicant gnome-keyring
    ```
1. 노트북일 경우 터치패드 지원
    ```bash
    pacman -S xf86-input-synaptics
    ```

### GNOME

```bash
pacman -S gnome
systemctl enable gdm.service
```

### Xfce

```bash
pacman -S xorg-server xorg-server-utils
pacman -S xfce4
```

디스플레이 매니저 설치, 여기선 GDM을 사용해보자

```bash
pacman -S gdm
systemctl enable gdm.service
```

### KDE

```bash
pacman -S xorg-server xorg-server-utils
pacman -S plasma
pacman -S kde-l10n-ko
systemctl enable sddm.service
```

기본 프로그램을 반드시 설치해주어야한다.

```bash
pacman -S konsole dolphin kdemultimedia-kmix
```

sddm 설정

```bash
nano /etc/sddm.conf
```
- `Current=breeze`

## 끝

```bash
exit
umount -R /mnt/boot
umount -R /mnt
reboot
```
