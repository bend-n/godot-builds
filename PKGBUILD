# Maintainer: bendn <bend.n@outlook.com>
# shellcheck disable=SC2148,SC2034

pkgname="godot2d"
pkgver='3.5.stable'
pkgrel=1
pkgdesc="godot builds without all the 3d stuff."
arch=('any')
url="https://github.com/bend-n/godot-builds"
license=('MIT')
depends=(libxcursor libxinerama libxi libxrandr libglvnd)
makedepends=('github-cli' 'git')
md5sums=()
source=()
provides=('godot2d')

_repo="github.com/bend-n/godot-builds"

_get() {
	gh run download "$1" -n "$2" -R "$_repo"
}

package() {
	id=$(gh workflow view build-3.5-2d.yml | sed '6q;d' | awk -F'\t' '{print $8}')
	_get "$id" "x11-tools-release" &
	_get "$id" "templates"
	install -Dm755 godot.x11.opt.tools.64 "$pkgdir/usr/bin/godot2d"
	install -Dm755 "$pkgdir/usr/share/godot/templates/${pkgver}.stable"
	unzip -of templates.tpz -d "$pkgdir/usr/share/godot/templates/${pkgver}.stable"
}
