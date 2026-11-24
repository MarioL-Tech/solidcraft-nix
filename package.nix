{
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
}:

let
  pname = "solidcraft";
  version = "0.45.0";
  src = fetchurl {
    url = "https://github.com/tangency-labs/solidcraft/releases/download/v${version}/solidcraft-${version}-linux-x86_64.AppImage";
    # SHA256SUMS.txt from the same upstream release.
    hash = "sha256-rEUzhf/UXtWcYQS8wwqgHLhTvP4zi96qfkLCTMbNHC8=";
  };
  contents = appimageTools.extractType2 { inherit pname version src; };
  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = "SolidCraft";
    comment = "Parametric 3D CAD";
    exec = "${pname} %f";
    icon = pname;
    categories = [ "Graphics" "3DGraphics" "Engineering" ];
    mimeTypes = [ "application/x-solidcraft" "model/step" "model/iges" "model/stl" "model/3mf" ];
    startupWMClass = "io.tangencylabs.solidcraft";
    terminal = false;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm444 ${desktopItem}/share/applications/${pname}.desktop \
      $out/share/applications/${pname}.desktop
    install -Dm444 ${contents}/.DirIcon \
      $out/share/icons/hicolor/256x256/apps/${pname}.png
  '';

  meta = {
    description = "SolidCraft desktop application";
    homepage = "https://github.com/tangency-labs/solidcraft";
    changelog = "https://github.com/tangency-labs/solidcraft/releases/tag/v${version}";
    license = lib.licenses.asl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
