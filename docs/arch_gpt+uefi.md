설치 전 할 일
--------
홍차 한 잔을 준비한다 (중요)

VirtualBox라면 VM 설정에서 EFI 사용을 체크한다

ArchLinux 홈페이지에서 [Archlinux ISO 파일](https://www.archlinux.org/download/)을 받는다

[Rufus](https://rufus.akeo.ie/)에서 GPT 파티션 형식의 UEFI로 부팅디스크 생성 (VM은 불필요)

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
    # Server = http://ftp.kaist.ac.kr/ArchLinux/$repo/os/$arch
pacstrap /mnt base base-devel grub efibootmgr sudo openssh
genfstab -U /mnt >> /mnt/etc/fstab
echo '<PC_NAME>' > /mnt/etc/hostname # 컴퓨터 이름 설정
arch-chroot /mnt
```

<br>

설치 직 후 할 일
--------
```bash
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

# Grub 설치, 대기시간 줄이기
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub --recheck
nano /etc/default/grub
    # GRUB_TIMEOUT=1
grub-mkconfig -o /boot/grub/grub.cfg

# (VirtualBox) VirtualBox 패키지 설치
pacman -S virtualbox-guest-utils virtualbox-guest-modules-arch
systemctl enable vboxservice.service
VBoxClient-all # 재부팅 후 해야함
```

<br>

GUI 설치
--------
### 사전 준비
```bash
# 그래픽 카드 드라이버 설치
pacman -S mesa xf86-video-intel
# 네트워크 매니저 설치
pacman -S network-manager-applet networkmanager
# 무선 네트워크가 필요하다면
pacman -S iw wpa_supplicant gnome-keyring
# 노트북일 경우 터치패드 지원
pacman -S xf86-input-synaptics
systemctl enable NetworkManager.service
```

### GNOME
```bash
# GNOME 설치
pacman -S gnome
# 서비스 활성화
systemctl enable gdm.service
```

### Xfce
```bash
# X Server 설치
pacman -S xorg-server xorg-server-utils
# Xfce 설치
pacman -S xfce4
# 디스플레이 매니저 설치, 여기선 GDM을 사용해보자
pacman -S gdm
# 서비스 활성화
systemctl enable gdm.service
```

### KDE
```bash
# X Server 설치
pacman -S xorg-server xorg-server-utils
# Plasma 설치
pacman -S plasma
# 기본 프로그램 설치
pacman -S konsole dolphin kdemultimedia-kmix
# Theme 변경
nano /etc/sddm.conf
    # Current=breeze
# 언어팩 설치
pacman -S kde-l10n-ko
# 디스플레이 매니저 서비스 활성화
systemctl enable sddm.service
```

<br>

끝
--------
```bash
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
- vim git tmux wget zip
- python python-pip
- powerline-fonts noto-fonts
- (내 노트북) b43-firmware([AUR](https://aur.archlinux.org/b43-firmware.git))

### 도움 되는 유틸들
- ttf-nanum([AUR](https://aur.archlinux.org/ttf-nanum.git))
- [ibus](https://wiki.archlinux.org/index.php/Internationalization/Korean_(%ED%95%9C%EA%B5%AD%EC%96%B4) ibus-hangul
- (GTK 계열) gedit(또는 mousepad) galculator
- (KDE 계열) ark dolphin-plugins dragon gwenview kalgebra kate kcalc kdenetwork-kget kdeutils-sweeper kfind konqueror kwrite okular spectacle
- xarchiver

<br>

기타
--------
### 터미널에서 한글 입력이 안되거나 ibus가 자동시작하지 않는 경우
```bash
sudo nano ~/.xprofile
    # export GTK_IM_MODULE=ibus
	# export XMODIFIERS=@im=ibus
	# export QT_IM_MODULE=ibus
	# ibus-daemon -drx
```
### VirtualBox의 UEFI Interactive Shell에서 막힌다면
```bash
edit startup.nsh
    # FS0:
    # \EFI\grub\grubx64.efi
```
