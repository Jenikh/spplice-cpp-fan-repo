# === Build .deb package ===
if [ "$target_linux" == true ]; then
  echo "Packing .deb..."

  mkdir -p $build_root/deb/usr/bin
  cp $build_root/dist/linux/SppliceCPP $build_root/deb/usr/bin/spplice

  mkdir -p $build_root/deb/DEBIAN
  cat > $build_root/deb/DEBIAN/control <<EOF
Package: spplice
Version: 1.0.0
Section: base
Priority: optional
Architecture: amd64
Depends: libqt5core5a, libqt5widgets5
Maintainer: Spplice Team
Description: Spplice C++ Package Manager UI
EOF

  dpkg-deb --build $build_root/deb $build_root/dist/spplice.deb
fi


# === Build .AppImage ===
if [ "$target_linux" == true ]; then
  echo "Packing .AppImage..."

  mkdir -p $build_root/appdir/usr/bin
  cp $build_root/dist/linux/SppliceCPP $build_root/appdir/usr/bin/spplice

  mkdir -p $build_root/appdir/usr/share/applications
  cat > $build_root/appdir/usr/share/applications/spplice.desktop <<EOF
[Desktop Entry]
Name=Spplice
Exec=spplice
Icon=spplice
Type=Application
Categories=Development;
EOF

  mkdir -p $build_root/appdir/usr/share/icons
  cp $build_root/logo.png $build_root/appdir/usr/share/icons/spplice.png 2>/dev/null || true

  wget -q https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage -O $build_root/appimagetool
  chmod +x $build_root/appimagetool
  $build_root/appimagetool $build_root/appdir $build_root/dist/spplice.AppImage
fi
