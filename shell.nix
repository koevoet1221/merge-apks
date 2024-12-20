{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) system;
  config = {
    android_sdk.accept_license = true;
  };
  buildToolsVersion = "33.0.2";
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ buildToolsVersion ];
  };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.apktool
    pkgs.apksigner
    pkgs.android-tools
  ];

  shellHook = ''
    export PATH=$PATH:${androidComposition.androidsdk}/libexec/android-sdk/build-tools/${buildToolsVersion}
    zipAlignPath="${androidComposition.androidsdk}/libexec/android-sdk/build-tools/${buildToolsVersion}/zipalign"
    echo "zipalign path is set to: $zipAlignPath"
  '';
}
