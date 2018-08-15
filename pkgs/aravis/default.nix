{ stdenv, fetchurl, autoreconfHook, pkgconfig, gtk_doc, intltool
, glib, libxml2
}:

stdenv.mkDerivation rec {
  pname = "aravis";
  version = "0.5.13";
  name = "${pname}-${version}";

  src = fetchurl {
    url = https://github.com/AravisProject/aravis/archive/ARAVIS_0_5_13.tar.gz;
    sha256 = "1dh9a4xxy78sxbcg7dyh7p4k9j31l4g510138z0cv0rh2xamilkd";
  };

  nativeBuildInputs = [
    autoreconfHook pkgconfig gtk_doc intltool
    glib libxml2
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  postPatch = ''
    ln -s ${gtk_doc}/share/gtk-doc/data/gtk-doc.make .
  '';

  doCheck = true;

  meta = {
    description = "Library for video acquisition using Genicam cameras.";
    longDescription = ''
      Implements the gigabit ethernet and USB3 protocols used by industrial cameras.
    '';
    homepage = https://aravisproject.github.io/docs/aravis-0.5;
    license = stdenv.lib.licenses.lgpl2;
    maintainers = [];
    platforms = stdenv.lib.platforms.unix;
  };
}

