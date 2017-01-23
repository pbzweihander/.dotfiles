설치 전 할 일
--------
홍차 한 잔을 준비한다 (중요)

VirtualBox라면 VM 설정에서 EFI 사용을 체크한다

ArchLinux 홈페이지에서 Archlinux ISO 파일을 받는다

Rufus에서 GPT 파티션 형식의 UEFI로 부팅디스크 생성 (VM은 불필요)

부팅디스크로 부팅한다

<br>

부팅미디어에서 할 일
--------
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

nano /etc/pacman.d/mirrorlist # 미러 우선순위 변경
    # Server = http://mirror.premi.st/archlinux/$repo/os/$arch
pacstrap /mnt base grub efibootmgr sudo openssh
genfstab -U /mnt >> /mnt/etc/fstab
echo '<PC_NAME>' > /mnt/etc/hostname # 컴퓨터 이름 설정
arch-chroot /mnt /bin/bash
```

<br>

설치 직후 할 일
--------
```bash
# Timezone 설정
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Locale 설정
nano /etc/locale.gen
    # en_US.UTF-8 UTF-8
    # ko_KR.UTF-8 UTF-8
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
set LANG en_US.UTF-8

# 하드웨어 시계 설정
hwclock --systohc --utc

# Grub 설치, 대기시간 줄이기
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub --recheck
nano /etc/default/grub
    # GRUB_TIMEOUT=1
grub-mkconfig -o /boot/grub/grub.cfg

# 새 유저 생성, root 잠그기
useradd -m -G wheel -s /bin/bash thomas
passwd thomas
EDITOR=nano visudo # sudoer에 wheel 그룹 추가
passwd root -dl

# ssh 설정
nano /etc/ssh/sshd_config
systemctl enable sshd

# 네트워크 인터페이스 확인
ip link
# DHCP 설정, 아래 네트워크 매니저 설치시 불필요
nano /etc/systemd/network/<interface>.network
    # [Match]
    # Name=en*
    #
    # [Network]
    # DHCP=ipv4
systemctl enable systemd-networkd.service
# DHCP DNS 설정
nano /etc/resolv.conf
    # nameserver 8.8.8.8
    # nameserver 8.8.4.4

# (VirtualBox) VirtualBox 패키지 설치
pacman -S virtualbox-guest-utils virtualbox-guest-modules-arch
systemctl enable vboxservice.service
VBoxClient-all # 재부팅 후 해야함

# (필요할 경우) 그래픽 카드 드라이버 설치
pacman -S mesa
# GNOME 설치
pacman -S gnome gnome-extra
# 네트워크 매니저 설치
pacman -S network-manager-applet networkmanager
# 무선 네트워크가 필요하다면
pacman -S iw wpa_supplicant dialog
# 노트북일 경우 터치패드 지원
pacman -S xf86-input-synaptics
# 자동 완성 설치, 굳이 GNOME 설치 중이 아니더라도 필요할듯
pacman -S bash-completion
# 서비스 활성화
systemctl enable NetworkManager.service
systemctl enable gdm.service

# 재부팅
exit
umount -R /mnt/boot
umount -R /mnt
reboot
```

<br>

설치 후 할 일
--------
### 필수 설치
- vim git tmux fish wget zip
- python python-pip python-setuptools elixir
- powerline-fonts ttf-dejavu ttf-nanum(AUR) noto-fonts
- ibus ibus-hangul

### VirtualBox의 UEFI Interactive Shell에서 막힌다면
```bash
edit startup.nsh
    # FS0:
    # /EFI/grub_
```
