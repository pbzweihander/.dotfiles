# systemd-boot

아치리눅스에 GRUB 대신에 systemd-boot를 사용해보자

### 장점

- Windows Boot Manager를 자동으로 인식해주므로 듀얼부팅에 편하다
- systemd에 포함되어있고, systemd는 아치리눅스에 기본적으로 포함되어있다

### 단점

- EFI밖에 안된다
- 일일히 설정해줘야함

## 부팅미디어에서 시작

```bash
ls /sys/firmware/efi/efivars # 폴더가 존재한다면 UEFI로 부팅 성공

timedatectl set-ntp true # 시계 업데이트

cgdisk /dev/sda # 디스크 파티셔닝
    # /dev/sda1 : 512MB, EFI System(EF00)
    # /dev/sda2 : 2GB, Linux swap(8200)
    # /dev/sda3 : Linux filesystem(8300, default)
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3

mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

> **만약 윈도우를 미리 설치했었다면**
> EFI System Partition (ESP)가 이미 생성되어있을 것이다.
> 그러므로 ESP (위 예에서 sd1)을 따로 만들 필요 없이, 이미 있는 ESP를 boot에 마운트하여 설치하면 된다.


```bash
nano /etc/pacman.d/mirrorlist # 미러 우선순위 변경
    # Server = http://mirror.premi.st/archlinux/$repo/os/$arch
    # Server = http://ftp.kaist.ac.kr/ArchLinux/$repo/os/$arch
pacstrap /mnt base base-devel sudo # systemd-boot는 아치리눅스에 포함되어있으므로 따로 설치할 필요 없다.
```

> **인텔 CPU를 사용 중이라면**
> `intel-ucode` 패키지를 설치하도록 하자 (왜인진 모름)

```bash
# fstab 파일 생성
genfstab -U /mnt >> /mnt/etc/fstab

# chroot
arch-chroot /mnt

# Timezone 설정
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
hwclock --systohc --utc

# Locale 설정
nano /etc/locale.gen
    # en_US.UTF-8 UTF-8
    # ko_KR.UTF-8 UTF-8
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

# 컴퓨터 이름 설정
echo '<PC_NAME>' > /mnt/etc/hostname
nano /etc/hosts
	# ...
	# 127.0.1.1 <PC_NAME>.localdomain <PC_NAME>

# 네트워크 설정
ip link # 네트워크 인터페이스 이름 확인
ip link set <interface> up
# DHCP를 설정하거나, NetworkManager를 설치하자

# 새 유저 생성, root 잠그기
useradd -m -G sudo -s /bin/bash <username>
passwd <username>
EDITOR=nano visudo
	# %sudo ALL=(ALL) ALL 라고 적혀있는 줄을 uncomment
passwd root -dl
```

### bootloader 설정하기

```bash
# 설치
bootctl --path=/boot install

# 설정
nano /boot/loader/loader.conf
	# default arch
	# timeout 4
	# editor 0

# PARTUUID 확인
blkid -s PARTUUID -o value /dev/sda3 # ESP가 아닌 root 파티션의 ID를 확인하자

# 아치리눅스용 entry 추가 (윈도우는 자동으로 생성)
nano /boot/loader/entries/arch.conf
	# title Arch Linux
	# linux /vmlinuz-linux
	# initrd /initramfs-linux.img
	# options root=PARTUUID=<ID> rw
```

## 끝!

이제 다른 GUI들을 설치하고 리붓하면 된다

