# Maintainer: Yangers Puentes <yangers@gmail.com>
pkgname=omarchy-session-restore
pkgver=1.0.0
pkgrel=1
pkgdesc="macOS-style session save & restore with interactive boot prompt for Omarchy (Hyprland + Wayland)"
arch=('any')
url="https://github.com/Yangers/omarchy-session-restore"
license=('MIT')
depends=('python' 'hyprland' 'libnotify' 'omarchy')
optdepends=(
    'chromium: Chrome/Chromium tab and window state restoration'
    'foot: Wayland terminal with working directory restore'
    'herdr: Terminal workspace manager for AI coding agents'
    'visual-studio-code-bin: VS Code window and project restoration'
)
source=("$pkgname-$pkgver.tar.gz::$url/archive/v$pkgver.tar.gz")
sha256sums=('SKIP')

package() {
    cd "$srcdir"
    install -Dm755 bin/omarchy-session "$pkgdir/usr/bin/omarchy-session"
}
